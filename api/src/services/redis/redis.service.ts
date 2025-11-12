import Redis, { RedisOptions } from 'ioredis';
import { Injectable, OnModuleDestroy } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class RedisService implements OnModuleDestroy {
  private client: Redis | null = null;
  private connectionConfig: RedisOptions | null = null;
  private idleTimeout: NodeJS.Timeout | null = null;
  private readonly IDLE_TIMEOUT_MS = 5 * 60 * 1000; // 5 minutes
  private lastActivityTime: number = 0;

  constructor(private readonly configService: ConfigService) {
    // Parse Redis URL configuration
    const redisUrl = new URL(
      this.configService.get('REDIS_URL') || 'redis://localhost:6379',
    );

    this.connectionConfig = {
      host: redisUrl.hostname,
      port: parseInt(redisUrl.port, 10),
      password: redisUrl.password || undefined,
      db: redisUrl.pathname ? parseInt(redisUrl.pathname.slice(1), 10) : 0,
      family: 0, // Use IPv4
      lazyConnect: true, // Don't connect immediately
      retryStrategy: (times) => {
        // Retry with exponential backoff, max 3 seconds
        const delay = Math.min(times * 50, 3000);
        return delay;
      },
      maxRetriesPerRequest: 3,
    };
  }

  /**
   * Get or create Redis client, connecting on-demand
   */
  private async getClient(): Promise<Redis> {
    // If client exists and is ready, return it
    if (this.client && this.client.status === 'ready') {
      this.updateActivityTime();
      return this.client;
    }

    // If client exists and is reconnecting, wait for it to be ready
    if (this.client && this.client.status === 'reconnecting') {
      return new Promise((resolve, reject) => {
        const timeout = setTimeout(() => {
          reject(new Error('Redis reconnection timeout'));
        }, 10000); // 10 second timeout

        const onReady = () => {
          clearTimeout(timeout);
          this.client!.removeListener('error', onError);
          this.updateActivityTime();
          resolve(this.client!);
        };

        const onError = (error: Error) => {
          clearTimeout(timeout);
          this.client!.removeListener('ready', onReady);
          reject(error);
        };

        this.client!.once('ready', onReady);
        this.client!.once('error', onError);
      });
    }

    // If client exists but not connected, try to reconnect
    if (this.client && this.client.status !== 'ready') {
      try {
        // If client is in 'end' state, we need to create a new one
        if (this.client.status === 'end') {
          this.client.disconnect();
          this.client = null;
        } else {
          // Try to connect if not already connecting
          if (this.client.status === 'wait') {
            await this.client.connect();
            this.updateActivityTime();
            return this.client;
          }
        }
      } catch (error) {
        console.error('Failed to reconnect Redis client:', error);
        // Create new client if reconnect fails
        if (this.client) {
          this.client.disconnect();
        }
        this.client = null;
      }
    }

    // Create new client and connect
    this.client = new Redis(this.connectionConfig!);
    
    // Set up error handlers
    this.client.on('error', (error) => {
      console.error('Redis client error:', error);
    });

    this.client.on('connect', () => {
      console.log('Redis client connected');
    });

    this.client.on('close', () => {
      console.log('Redis client disconnected');
    });

    try {
      await this.client.connect();
      this.updateActivityTime();
      return this.client;
    } catch (error) {
      console.error('Failed to connect to Redis:', error);
      // Clean up on connection failure
      if (this.client) {
        this.client.disconnect();
        this.client = null;
      }
      throw error;
    }
  }

  /**
   * Update last activity time and schedule idle disconnect
   */
  private updateActivityTime(): void {
    this.lastActivityTime = Date.now();

    // Clear existing timeout
    if (this.idleTimeout) {
      clearTimeout(this.idleTimeout);
    }

    // Schedule disconnect after idle timeout
    this.idleTimeout = setTimeout(() => {
      this.disconnectIfIdle();
    }, this.IDLE_TIMEOUT_MS);
  }

  /**
   * Disconnect if client has been idle for the timeout period
   */
  private async disconnectIfIdle(): Promise<void> {
    const timeSinceLastActivity = Date.now() - this.lastActivityTime;

    if (timeSinceLastActivity >= this.IDLE_TIMEOUT_MS && this.client) {
      console.log('Disconnecting Redis client due to inactivity');
      try {
        await this.client.quit();
      } catch (error) {
        console.error('Error disconnecting Redis client:', error);
        // Force disconnect if quit fails
        this.client.disconnect();
      }
      this.client = null;
      this.idleTimeout = null;
    }
  }

  /**
   * Get Redis client or null if not available
   * This method is used by services that check for Redis availability
   * Returns the service itself which implements the Redis interface methods
   */
  getOrNil(): RedisService {
    return this;
  }

  // Redis command methods that connect on-demand

  async get(key: string): Promise<string | null> {
    try {
      const client = await this.getClient();
      return await client.get(key);
    } catch (error) {
      console.error('Redis GET error:', error);
      return null;
    }
  }

  async setex(key: string, seconds: number, value: string): Promise<void> {
    try {
      const client = await this.getClient();
      await client.setex(key, seconds, value);
    } catch (error) {
      console.error('Redis SETEX error:', error);
      throw error;
    }
  }

  async del(key: string): Promise<number> {
    try {
      const client = await this.getClient();
      return await client.del(key);
    } catch (error) {
      console.error('Redis DEL error:', error);
      throw error;
    }
  }

  async lrange(key: string, start: number, stop: number): Promise<string[]> {
    try {
      const client = await this.getClient();
      return await client.lrange(key, start, stop);
    } catch (error) {
      console.error('Redis LRANGE error:', error);
      throw error;
    }
  }

  async lpush(key: string, ...values: string[]): Promise<number> {
    try {
      const client = await this.getClient();
      return await client.lpush(key, ...values);
    } catch (error) {
      console.error('Redis LPUSH error:', error);
      throw error;
    }
  }

  async expire(key: string, seconds: number): Promise<number> {
    try {
      const client = await this.getClient();
      return await client.expire(key, seconds);
    } catch (error) {
      console.error('Redis EXPIRE error:', error);
      throw error;
    }
  }

  /**
   * Cleanup on module destroy
   */
  async onModuleDestroy(): Promise<void> {
    if (this.idleTimeout) {
      clearTimeout(this.idleTimeout);
      this.idleTimeout = null;
    }

    if (this.client) {
      try {
        await this.client.quit();
      } catch (error) {
        console.error('Error closing Redis connection:', error);
        this.client.disconnect();
      }
      this.client = null;
    }
  }
}
