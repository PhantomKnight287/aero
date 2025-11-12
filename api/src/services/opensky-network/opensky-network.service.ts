import { RedisService } from 'src/services/redis/redis.service';
import {
  HttpException,
  HttpStatus,
  Injectable,
  OnModuleInit,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

export interface AircraftState {
  icao24: string;
  callsign: string | null;
  origin_country: string;
  time_position: number | null;
  last_contact: number;
  longitude: number | null;
  latitude: number | null;
  baro_altitude: number | null;
  on_ground: boolean;
  velocity: number | null;
  true_track: number | null;
  vertical_rate: number | null;
  sensors: number[] | null;
  geo_altitude: number | null;
  squawk: string | null;
  spi: boolean;
  position_source: number;
}

export interface OpenskyResponse {
  time: number;
  states: AircraftState[];
}

@Injectable()
export class OpenskyNetworkService implements OnModuleInit {
  private readonly baseUrl = 'https://opensky-network.org/api';
  private readonly openSkyAuthURL =
    'https://auth.opensky-network.org/auth/realms/opensky-network/protocol/openid-connect/token';
  private readonly rateLimitDelay = 1000; // 1 second delay between requests
  private readonly tokenCacheKey = 'opensky_access_token';
  private readonly tokenTTL = 29.5 * 60; // 29.5 minutes in seconds
  private lastRequestTime = 0;
  private redis: RedisService;

  constructor(
    private readonly redisService: RedisService,
    private readonly configService: ConfigService,
  ) {
    this.redis = this.redisService.getOrNil();
  }

  async onModuleInit() {
    // Initialize token on module startup
    await this.ensureValidToken();
  }

  private async ensureValidToken(): Promise<string> {
    try {
      // Check if token exists in Redis
      const cachedToken = await this.redis.get(this.tokenCacheKey);

      if (cachedToken) {
        return cachedToken;
      }

      // Generate new token if not cached
      return await this.generateNewToken();
    } catch (error) {
      console.error('Error ensuring valid token:', error);
      // Fallback to generating new token
      return await this.generateNewToken();
    }
  }

  private async generateNewToken(): Promise<string> {
    const clientId = this.configService.get<string>('OPENSKY_CLIENT_ID');
    const clientSecret = this.configService.get<string>(
      'OPENSKY_CLIENT_SECRET',
    );

    if (!clientId || !clientSecret) {
      console.warn(
        'OpenSky credentials not configured. Using unauthenticated requests.',
      );
      return '';
    }

    try {
      const formData = new URLSearchParams();
      formData.append('grant_type', 'client_credentials');
      formData.append('client_id', clientId);
      formData.append('client_secret', clientSecret);

      const response = await fetch(this.openSkyAuthURL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      });

      if (!response.ok) {
        throw new Error(`Authentication failed with status ${response.status}`);
      }

      const data = await response.json();
      const accessToken = data.access_token;

      if (!accessToken) {
        throw new Error('No access token received from OpenSky auth');
      }

      // Cache the token in Redis with TTL
      await this.redis.setex(this.tokenCacheKey, this.tokenTTL, accessToken);

      console.log('OpenSky access token generated and cached');
      return accessToken;
    } catch (error) {
      console.error('Failed to generate OpenSky token:', error);
      return '';
    }
  }
  /**
   * Get aircraft states within a bounding box
   */
  async getAircraftStatesInBounds(
    minLat: number,
    maxLat: number,
    minLng: number,
    maxLng: number,
  ): Promise<OpenskyResponse> {
    // Rate limiting
    const now = Date.now();
    const timeSinceLastRequest = now - this.lastRequestTime;
    if (timeSinceLastRequest < this.rateLimitDelay) {
      await new Promise((resolve) =>
        setTimeout(resolve, this.rateLimitDelay - timeSinceLastRequest),
      );
    }

    try {
      // Ensure we have a valid token
      const token = await this.ensureValidToken();

      const url = new URL(`${this.baseUrl}/states/all`);
      url.searchParams.append('lamin', minLat.toString());
      url.searchParams.append('lamax', maxLat.toString());
      url.searchParams.append('lomin', minLng.toString());
      url.searchParams.append('lomax', maxLng.toString());
      url.searchParams.append('extended', '1');

      const headers: Record<string, string> = {};
      
      // Add Bearer token if available
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }
      const response = await fetch(url.toString(), {
        headers,
      });

      this.lastRequestTime = Date.now();

      if (!response.ok) {
        if (response.status === 429) {
          throw new HttpException(
            'OpenSky API rate limit exceeded. Please try again later.',
            HttpStatus.TOO_MANY_REQUESTS,
          );
        }
        if (response.status === 401 && token) {
          // Token might be expired, try to generate a new one
          console.log('Token expired, generating new one...');
          await this.redis.del(this.tokenCacheKey);
          return this.getAircraftStatesInBounds(minLat, maxLat, minLng, maxLng);
        }
        throw new HttpException(
          `OpenSky API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      const data = await response.json();

      if (!data.states) {
        return {
          time: data.time || Date.now(),
          states: [],
        };
      }

      // Filter out invalid states and transform the data
      const validStates = data.states
        .filter((state: any[]) => state && state.length >= 17)
        .map(
          (state: any[]): AircraftState => ({
            icao24: state[0] || '',
            callsign: state[1] ? state[1].trim() : null,
            origin_country: state[2] || '',
            time_position: state[3],
            last_contact: state[4] || 0,
            longitude: state[5],
            latitude: state[6],
            baro_altitude: state[7],
            on_ground: state[8] || false,
            velocity: state[9],
            true_track: state[10],
            vertical_rate: state[11],
            sensors: state[12],
            geo_altitude: state[13],
            squawk: state[14],
            spi: state[15] || false,
            position_source: state[16] || 0,
          }),
        )
        .filter(
          (state: AircraftState) =>
            state.latitude &&
            state.longitude &&
            state.latitude >= minLat &&
            state.latitude <= maxLat &&
            state.longitude >= minLng &&
            state.longitude <= maxLng,
        );

      return {
        time: data.time || Date.now(),
        states: validStates,
      };
    } catch (error) {
      console.error('OpenSky API error:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch aircraft data from OpenSky Network',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  /**
   * Get aircraft states for a specific aircraft by ICAO24 code
   */
  async getAircraftState(icao24: string): Promise<AircraftState | null> {
    try {
      // Ensure we have a valid token
      const token = await this.ensureValidToken();

      const url = new URL(`${this.baseUrl}/states/all`);
      url.searchParams.append('icao24', icao24);

      const headers: Record<string, string> = {};

      // Add Bearer token if available
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      const response = await fetch(url.toString(), {
        headers,
      });

      if (!response.ok) {
        if (response.status === 401 && token) {
          // Token might be expired, try to generate a new one
          console.log('Token expired, generating new one...');
          await this.redis.del(this.tokenCacheKey);
          return this.getAircraftState(icao24);
        }
        throw new HttpException(
          `OpenSky API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      const data = await response.json();

      if (!data.states || data.states.length === 0) {
        return null;
      }

      const state = data.states[0];
      if (!state || state.length < 17) {
        return null;
      }

      return {
        icao24: state[0] || '',
        callsign: state[1] ? state[1].trim() : null,
        origin_country: state[2] || '',
        time_position: state[3],
        last_contact: state[4] || 0,
        longitude: state[5],
        latitude: state[6],
        baro_altitude: state[7],
        on_ground: state[8] || false,
        velocity: state[9],
        true_track: state[10],
        vertical_rate: state[11],
        sensors: state[12],
        geo_altitude: state[13],
        squawk: state[14],
        spi: state[15] || false,
        position_source: state[16] || 0,
      };
    } catch (error) {
      console.error('OpenSky API error:', error);
      throw new HttpException(
        'Failed to fetch aircraft data from OpenSky Network',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
