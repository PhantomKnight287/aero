import * as OneSignal from '@onesignal/node-onesignal';

import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

/**
 * Thin wrapper around the OneSignal node SDK for sending push notifications
 * to specific subscription (player) IDs.
 */
@Injectable()
export class OneSignalService {
  private readonly appId: string | undefined;
  private readonly client: OneSignal.DefaultApi | null;

  constructor(private readonly configService: ConfigService) {
    this.appId = this.configService.get<string>('ONESIGNAL_APP_ID');
    const restApiKey = this.configService.get<string>(
      'ONESIGNAL_REST_API_KEY',
    );

    if (this.appId && restApiKey) {
      const configuration = OneSignal.createConfiguration({ restApiKey });
      this.client = new OneSignal.DefaultApi(configuration);
    } else {
      this.client = null;
      console.warn(
        'OneSignal not configured (missing ONESIGNAL_APP_ID / ONESIGNAL_REST_API_KEY). Push notifications are disabled.',
      );
    }
  }

  get enabled(): boolean {
    return this.client !== null;
  }

  /**
   * Send a push notification to one or more subscription (player) IDs.
   * Silently no-ops when OneSignal is not configured or no recipients given.
   */
  async sendToPlayers(
    playerIds: string[],
    title: string,
    message: string,
    data?: Record<string, unknown>,
  ): Promise<void> {
    if (!this.client || !this.appId) return;
    const recipients = playerIds.filter(Boolean);
    if (recipients.length === 0) return;

    const notification = new OneSignal.Notification();
    notification.app_id = this.appId;
    notification.target_channel = 'push';
    notification.include_subscription_ids = recipients;
    notification.headings = { en: title };
    notification.contents = { en: message };
    if (data) notification.data = data;

    try {
      await this.client.createNotification(notification);
      console.log(
        `OneSignal: sent "${title}" to ${recipients.length} subscription(s)`,
      );
    } catch (error) {
      console.error('OneSignal: failed to send notification:', error);
    }
  }
}
