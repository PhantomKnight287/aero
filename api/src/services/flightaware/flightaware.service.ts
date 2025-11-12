import { RedisService } from 'src/services/redis/redis.service';
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

export interface FlightAwareAirport {
  code: string | null;
  code_icao?: string | null;
  code_iata?: string | null;
  code_lid?: string | null;
  timezone?: string | null;
  name?: string | null;
  city?: string | null;
  airport_info_url?: string | null;
}

export interface FlightAwareAircraft {
  fa_flight_id: string;
  ident: string;
  ident_icao?: string | null;
  ident_iata?: string | null;
  actual_runway_off?: string | null;
  actual_runway_on?: string | null;
  operator?: string | null;
  operator_icao?: string | null;
  operator_iata?: string | null;
  flight_number?: string | null;
  registration?: string | null;
  atc_ident?: string | null;
  inbound_fa_flight_id?: string | null;
  codeshares?: string[];
  codeshares_iata?: string[];
  blocked?: boolean;
  diverted?: boolean;
  cancelled?: boolean;
  position_only?: boolean;
  origin: FlightAwareAirport;
  destination?: FlightAwareAirport;
  departure_delay?: number | null;
  arrival_delay?: number | null;
  filed_ete?: number | null;
  progress_percent?: number | null;
  status: string;
  aircraft_type?: string | null;
  route_distance?: number | null;
  filed_airspeed?: number | null;
  filed_altitude?: number | null;
  route?: string | null;
  baggage_claim?: string | null;
  seats_cabin_business?: number | null;
  seats_cabin_coach?: number | null;
  seats_cabin_first?: number | null;
  gate_origin?: string | null;
  gate_destination?: string | null;
  terminal_origin?: string | null;
  terminal_destination?: string | null;
  type: 'General_Aviation' | 'Airline';
  scheduled_out?: string | null;
  estimated_out?: string | null;
  actual_out?: string | null;
  scheduled_off?: string | null;
  estimated_off?: string | null;
  actual_off?: string | null;
  scheduled_on?: string | null;
  estimated_on?: string | null;
  actual_on?: string | null;
  scheduled_in?: string | null;
  estimated_in?: string | null;
  actual_in?: string | null;
  foresight_predictions_available?: boolean;
  aircraft_type_faa?: string;
  aircraft_family?: string;
  manufacturer?: string;
  model?: string;
  engine_type?: string;
  engine_count?: string;
  wake_turbulence_category?: string;
  flight_plan?: {
    flight_plan_id: string;
    aircraft_id: string;
    aircraft_type: string;
    aircraft_faa?: string;
    aircraft_short?: string;
    owner?: string;
    owner_icao?: string;
    owner_iata?: string;
    owner_name?: string;
    manufacturer?: string;
    model?: string;
    priority?: string;
    filed_ete?: string;
    filed_departure_time?: string;
    estimated_departure_time?: string;
    filed_arrival_time?: string;
    estimated_arrival_time?: string;
    filed_airspeed_kts?: number;
    filed_airspeed_mach?: string;
    route_distance?: number;
    filed_altitude?: number;
    route?: string;
    actual_departure_time?: string;
    actual_arrival_time?: string;
    diverted?: string;
    origin: {
      code: string;
      code_icao?: string;
      code_iata?: string;
      code_lid?: string;
      timezone: string;
      name: string;
      city?: string;
      airport_info_url?: string;
    };
    destination?: {
      code: string;
      code_icao?: string;
      code_iata?: string;
      code_lid?: string;
      timezone: string;
      name: string;
      city?: string;
      airport_info_url?: string;
    };
    waypoints?: Array<{
      ident: string;
      name?: string;
      lat: number;
      lon: number;
      altitude?: number;
      alt_desc?: string;
      type?: string;
    }>;
  };
  origin_position?: {
    fa_flight_id: string;
    altitude: number;
    altitude_change?: string;
    groundspeed: number;
    heading: number;
    latitude: number;
    longitude: number;
    timestamp: string;
    update_type?: string;
  };
  destination_position?: {
    fa_flight_id: string;
    altitude: number;
    altitude_change?: string;
    groundspeed: number;
    heading: number;
    latitude: number;
    longitude: number;
    timestamp: string;
    update_type?: string;
  };
  waypoints?: Array<{
    fa_flight_id: string;
    altitude: number;
    altitude_change?: string;
    groundspeed: number;
    heading: number;
    latitude: number;
    longitude: number;
    timestamp: string;
    update_type?: string;
  }>;
  last_position?: {
    fa_flight_id: string;
    altitude: number;
    altitude_change?: string;
    groundspeed: number;
    heading: number;
    latitude: number;
    longitude: number;
    timestamp: string;
    update_type?: string;
  };
  bounding_box?: {
    fa_flight_id: string;
    num_positions: number;
    start_time: string;
    end_time: string;
    min_latitude: number;
    max_latitude: number;
    min_longitude: number;
    max_longitude: number;
  };
  has_forecast?: boolean;
  estimated_runway_arrival?: string;
  estimated_runway_departure?: string;
  actual_runway_arrival?: string;
  actual_runway_departure?: string;
}

export interface FlightAwareResponse {
  flights: FlightAwareAircraft[];
  links: {
    next?: string;
    prev?: string;
  };
  num_pages: number;
}

@Injectable()
export class FlightAwareService {
  private readonly baseUrl = 'https://aeroapi.flightaware.com/aeroapi';
  private readonly cacheTTL = 60; // 60 seconds cache (10 requests per minute limit)
  private readonly maxRequestsPerMinute = 10;
  private readonly rateLimitWindow = 60 * 1000; // 1 minute in milliseconds
  private redis: RedisService;

  constructor(
    private readonly redisService: RedisService,
    private readonly configService: ConfigService,
  ) {
    this.redis = this.redisService.getOrNil();
  }

  /**
   * Check and enforce rate limiting (10 requests per minute)
   */
  private async checkRateLimit(): Promise<void> {
    const rateLimitKey = 'flightaware:rate_limit';
    const now = Date.now();
    
    try {
      // Get current request timestamps
      const requestTimes = await this.redis.lrange(rateLimitKey, 0, -1);
      const currentTime = now;
      
      // Filter out requests older than 1 minute
      const recentRequests = requestTimes
        .map(time => parseInt(time))
        .filter(time => currentTime - time < this.rateLimitWindow);
      
      // Check if we're at the limit
      if (recentRequests.length >= this.maxRequestsPerMinute) {
        const oldestRequest = Math.min(...recentRequests);
        const waitTime = this.rateLimitWindow - (currentTime - oldestRequest);
        
        console.warn(`FlightAware: Rate limit reached (${this.maxRequestsPerMinute} requests/minute). Waiting ${Math.ceil(waitTime / 1000)} seconds...`);
        
        // Wait for the oldest request to expire
        await new Promise(resolve => setTimeout(resolve, waitTime + 1000));
      }
      
      // Add current request timestamp
      await this.redis.lpush(rateLimitKey, now.toString());
      await this.redis.expire(rateLimitKey, Math.ceil(this.rateLimitWindow / 1000));
      
      console.log(`FlightAware: Rate limit check passed (${recentRequests.length + 1}/${this.maxRequestsPerMinute} requests in last minute)`);
    } catch (error) {
      console.warn('FlightAware: Rate limit check failed, proceeding anyway:', error);
    }
  }

  /**
   * Get flights within a bounding box using FlightAware's search API
   */
  async getFlightsInBounds(
    minLat: number,
    maxLat: number,
    minLng: number,
    maxLng: number,
  ): Promise<FlightAwareResponse> {
    const cacheKey = `flightaware:flights:${minLat}:${maxLat}:${minLng}:${maxLng}`;

    // Check cache first
    try {
      const cached = await this.redis.get(cacheKey);
      if (cached) {
        const cachedData = JSON.parse(cached);
        console.log('FlightAware: Returning cached data');
        
        // Return in the same format as the API response
        return {
          flights: cachedData.flights,
          links: cachedData.links,
          num_pages: cachedData.num_pages
        };
      }
    } catch (error) {
      console.warn('Redis cache read error:', error);
    }

    const apiKey = this.configService.get<string>('FLIGHTAWARE_API_KEY');
    if (!apiKey) {
      throw new HttpException(
        'FlightAware API key not configured',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }

    try {
      // Check rate limit before making API call
      await this.checkRateLimit();
      
      // Build query for bounding box search using FlightAware CLI format
      const query = `-latlong "${minLat} ${minLng} ${maxLat} ${maxLng}"`;

      const url = new URL(`${this.baseUrl}/flights/search`);
      url.searchParams.append('query', query);
      url.searchParams.append('type', 'Position');

      const response = await fetch(url.toString(), {
        headers: {
          'x-apikey': apiKey,
          Accept: 'application/json; charset=UTF-8',
        },
      });

      if (!response.ok) {
        // Log error response
        const contentType = response.headers.get('content-type');
        let errorBody;
        
        try {
          if (contentType && contentType.includes('application/json')) {
            errorBody = await response.json();
          } else {
            errorBody = await response.text();
          }
          
          console.error('FlightAware API Error Response:', {
            status: response.status,
            statusText: response.statusText,
            contentType,
            body: errorBody,
            url: url.toString(),
          });
        } catch (logError) {
          console.error('Failed to log FlightAware error response:', logError);
        }

        if (response.status === 401) {
          throw new HttpException(
            'FlightAware API authentication failed',
            HttpStatus.UNAUTHORIZED,
          );
        }
        if (response.status === 429) {
          throw new HttpException(
            'FlightAware API rate limit exceeded',
            HttpStatus.TOO_MANY_REQUESTS,
          );
        }
        throw new HttpException(
          `FlightAware API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      let data = await response.json();
      let allFlights = data.flights || [];
      let nextUrl = data.links?.next;

      // Follow pagination links to get all flights
      while (nextUrl) {
        try {
          console.log(`FlightAware: Fetching next page: ${nextUrl}`);
          
          // Check rate limit before each pagination request
          await this.checkRateLimit();
          
          const nextResponse = await fetch(`${this.baseUrl}${nextUrl}`, {
            headers: {
              'x-apikey': apiKey,
              Accept: 'application/json; charset=UTF-8',
            },
          });

          if (!nextResponse.ok) {
            console.warn(`FlightAware: Failed to fetch next page (${nextResponse.status}), stopping pagination`);
            break;
          }

          const nextData = await nextResponse.json();
          allFlights = allFlights.concat(nextData.flights || []);
          nextUrl = nextData.links?.next;
          
          console.log(`FlightAware: Fetched ${nextData.flights?.length || 0} more flights, total: ${allFlights.length}`);
        } catch (paginationError) {
          console.error('FlightAware: Error fetching next page:', paginationError);
          break;
        }
      }

      // Create final response with all flights
      const finalData = {
        ...data,
        flights: allFlights
      };

      // Cache both the processed data and raw API response
      try {
        const processedData = {
          flights: allFlights,
          links: data.links || {},
          num_pages: data.num_pages || 0,
          cached_at: new Date().toISOString(),
          query: query,
          bounds: { minLat, maxLat, minLng, maxLng },
          total_flights_fetched: allFlights.length
        };
        
        // Cache the processed data (what we return)
        await this.redis.setex(cacheKey, this.cacheTTL, JSON.stringify(processedData));
        
        // Cache the raw API response for analysis
        const rawCacheKey = `${cacheKey}:raw`;
        await this.redis.setex(rawCacheKey, this.cacheTTL, JSON.stringify(finalData));
        
        console.log(`FlightAware: Fetched ${allFlights.length} total flights across all pages, cached for 10 seconds`);
      } catch (error) {
        console.warn('Redis cache write error:', error);
      }

      return finalData;
    } catch (error) {
      console.error('FlightAware API error:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch flight data from FlightAware',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  /**
   * Search flights by ident (returns array of flights)
   */
  async searchFlightsByIdent(ident: string): Promise<FlightAwareResponse | null> {
    const cacheKey = `flightaware:search:${ident}`;

    // Check cache first
    try {
      const cached = await this.redis.get(cacheKey);
      if (cached) {
        console.log(`FlightAware: Returning cached search data for ${ident}`);
        return JSON.parse(cached);
      }
    } catch (error) {
      console.warn('Redis cache read error:', error);
    }

    const apiKey = this.configService.get<string>('FLIGHTAWARE_API_KEY');
    if (!apiKey) {
      throw new HttpException(
        'FlightAware API key not configured',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }

    try {
      // Check rate limit before making API call
      await this.checkRateLimit();
      
      const url = new URL(`${this.baseUrl}/flights/${ident}`);

      const response = await fetch(url.toString(), {
        headers: {
          'x-apikey': apiKey,
          Accept: 'application/json; charset=UTF-8',
        },
      });

      if (!response.ok) {
        // Log error response
        const contentType = response.headers.get('content-type');
        let errorBody;
        
        try {
          if (contentType && contentType.includes('application/json')) {
            errorBody = await response.json();
          } else {
            errorBody = await response.text();
          }
          
          console.error('FlightAware API Error Response:', {
            status: response.status,
            statusText: response.statusText,
            contentType,
            body: errorBody,
            url: url.toString(),
            ident,
          });
        } catch (logError) {
          console.error('Failed to log FlightAware error response:', logError);
        }

        if (response.status === 404) {
          return null;
        }
        if (response.status === 401) {
          throw new HttpException(
            'FlightAware API authentication failed',
            HttpStatus.UNAUTHORIZED,
          );
        }
        throw new HttpException(
          `FlightAware API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      const data = await response.json();

      // Cache both the processed data and raw API response
      try {
        const processedData = {
          ...data,
          cached_at: new Date().toISOString(),
          ident: ident
        };
        
        // Cache the processed data (what we return)
        await this.redis.setex(cacheKey, this.cacheTTL, JSON.stringify(processedData));
        
        // Cache the raw API response for analysis
        const rawCacheKey = `${cacheKey}:raw`;
        await this.redis.setex(rawCacheKey, this.cacheTTL, JSON.stringify(data));
        
        console.log(
          `FlightAware: Search data for ${ident} cached for 10 seconds (processed + raw)`,
        );
      } catch (error) {
        console.warn('Redis cache write error:', error);
      }

      return data;
    } catch (error) {
      console.error('FlightAware API error:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch flight data from FlightAware',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  /**
   * Get flight track data (positions) by fa_flight_id
   * Note: This method caches at the FlightAware service level.
   * The application layer (flight.service.ts) has its own 30s cache.
   */
  async getFlightTrack(faFlightId: string): Promise<any> {
    const cacheKey = `flightaware:track:${faFlightId}`;
    const trackCacheTTL = 30; // 30 seconds to manage rate limits

    // Check cache first
    try {
      const cached = await this.redis.get(cacheKey);
      if (cached) {
        console.log(`FlightAware: Returning cached track data for ${faFlightId}`);
        return JSON.parse(cached);
      }
    } catch (error) {
      console.warn('Redis cache read error:', error);
    }

    const apiKey = this.configService.get<string>('FLIGHTAWARE_API_KEY');
    if (!apiKey) {
      throw new HttpException(
        'FlightAware API key not configured',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }

    try {
      // Check rate limit before making API call
      await this.checkRateLimit();
      
      const url = new URL(`${this.baseUrl}/flights/${faFlightId}/track`);

      const response = await fetch(url.toString(), {
        headers: {
          'x-apikey': apiKey,
          Accept: 'application/json; charset=UTF-8',
        },
      });

      if (!response.ok) {
        // Log error response
        const contentType = response.headers.get('content-type');
        let errorBody;
        
        try {
          if (contentType && contentType.includes('application/json')) {
            errorBody = await response.json();
          } else {
            errorBody = await response.text();
          }
          
          console.error('FlightAware API Error Response:', {
            status: response.status,
            statusText: response.statusText,
            contentType,
            body: errorBody,
            url: url.toString(),
            faFlightId,
          });
        } catch (logError) {
          console.error('Failed to log FlightAware error response:', logError);
        }

        if (response.status === 404) {
          throw new HttpException(
            'Flight track not found',
            HttpStatus.NOT_FOUND,
          );
        }
        if (response.status === 401) {
          throw new HttpException(
            'FlightAware API authentication failed',
            HttpStatus.UNAUTHORIZED,
          );
        }
        throw new HttpException(
          `FlightAware API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      const data = await response.json();

      // Cache the data for 30 seconds
      try {
        const processedData = {
          ...data,
          cached_at: new Date().toISOString(),
          fa_flight_id: faFlightId
        };
        
        await this.redis.setex(cacheKey, trackCacheTTL, JSON.stringify(processedData));
        
        console.log(
          `FlightAware: Track data for ${faFlightId} cached for ${trackCacheTTL} seconds`,
        );
      } catch (error) {
        console.warn('Redis cache write error:', error);
      }

      return data;
    } catch (error) {
      console.error('FlightAware API error:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch flight track data from FlightAware',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  /**
   * Get a specific flight by ident
   */
  async getFlightByIdent(ident: string): Promise<FlightAwareAircraft | null> {
    const cacheKey = `flightaware:flight:${ident}`;

    // Check cache first
    try {
      const cached = await this.redis.get(cacheKey);
      if (cached) {
        console.log(`FlightAware: Returning cached flight data for ${ident}`);
        return JSON.parse(cached);
      }
    } catch (error) {
      console.warn('Redis cache read error:', error);
    }

    const apiKey = this.configService.get<string>('FLIGHTAWARE_API_KEY');
    if (!apiKey) {
      throw new HttpException(
        'FlightAware API key not configured',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }

    try {
      // Check rate limit before making API call
      await this.checkRateLimit();
      
      const url = new URL(`${this.baseUrl}/flights/${ident}`);

      const response = await fetch(url.toString(), {
        headers: {
          'x-apikey': apiKey,
          Accept: 'application/json; charset=UTF-8',
        },
      });

      if (!response.ok) {
        // Log error response
        const contentType = response.headers.get('content-type');
        let errorBody;
        
        try {
          if (contentType && contentType.includes('application/json')) {
            errorBody = await response.json();
          } else {
            errorBody = await response.text();
          }
          
          console.error('FlightAware API Error Response:', {
            status: response.status,
            statusText: response.statusText,
            contentType,
            body: errorBody,
            url: url.toString(),
            ident,
          });
        } catch (logError) {
          console.error('Failed to log FlightAware error response:', logError);
        }

        if (response.status === 404) {
          return null;
        }
        if (response.status === 401) {
          throw new HttpException(
            'FlightAware API authentication failed',
            HttpStatus.UNAUTHORIZED,
          );
        }
        throw new HttpException(
          `FlightAware API request failed with status ${response.status}`,
          HttpStatus.BAD_GATEWAY,
        );
      }

      const data = await response.json();

      // Cache both the processed data and raw API response
      try {
        const processedData = {
          ...data,
          cached_at: new Date().toISOString(),
          ident: ident
        };
        
        // Cache the processed data (what we return)
        await this.redis.setex(cacheKey, this.cacheTTL, JSON.stringify(processedData));
        
        // Cache the raw API response for analysis
        const rawCacheKey = `${cacheKey}:raw`;
        await this.redis.setex(rawCacheKey, this.cacheTTL, JSON.stringify(data));
        
        console.log(
          `FlightAware: Flight data for ${ident} cached for 10 seconds (processed + raw)`,
        );
      } catch (error) {
        console.warn('Redis cache write error:', error);
      }

      return data;
    } catch (error) {
      console.error('FlightAware API error:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch flight data from FlightAware',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
