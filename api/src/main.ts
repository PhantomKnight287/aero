import 'dotenv/config';
import { Request, Response } from 'express';
import { existsSync, mkdirSync, writeFileSync } from 'fs';
import morgan from 'morgan';
import { join } from 'path';

import { ValidationPipe, VersioningType } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { apiReference } from '@scalar/nestjs-api-reference';

import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.use(morgan('dev'));
  app.enableCors();
  app.getHttpAdapter().post('/alerts/:id', async (req, res) => {
    const folderPath = join(process.cwd(), 'alerts', (req as any).params.id);
    if (!existsSync(folderPath)) {
      mkdirSync(folderPath, { recursive: true });
    }
    writeFileSync(
      join(folderPath, `${new Date().getTime()}.json`),
      JSON.stringify(
        {
          headers: (req as any).headers,
          body: (req as any).body,
        },
        null,
        2,
      ),
    );

    return (res as any).json({
      ok: true,
    });
  });
  app
    .getHttpAdapter()
    .get('/.well-known/assetlinks.json', (req: Request, res: Response) => {
      return res.json([
        {
          relation: ['delegate_permission/common.handle_all_urls'],
          target: {
            namespace: 'android_app',
            package_name: 'com.phantomknight287.planepal',
            sha256_cert_fingerprints: [
              '9E:A9:13:EE:1A:D2:F8:58:56:8F:EA:F4:5E:61:CE:29:11:0A:1A:2B:59:4B:2B:43:07:1F:9A:2F:9F:71:FE:D4',
            ],
          },
        },
      ]);
    });

  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      enableDebugMessages: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );
  const config = new DocumentBuilder()
    .setTitle('Plane Pal')
    .setDescription('Plane Pal API Documentation')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
      },
      'JWT-auth',
    )
    .build();

  const document = SwaggerModule.createDocument(app, config);
  Object.values(document.paths).forEach((path: any) => {
    Object.values(path).forEach((method: any) => {
      if (!method.responses) {
        method.responses = {};
      }
      method.responses['500'] = {
        description: 'Internal server error',
        content: {
          'application/json': {
            schema: {
              $ref: '#/components/schemas/GenericErrorEntity',
            },
          },
        },
      };
    });
  });
  writeFileSync('./openapi.json', JSON.stringify(document, null, 2));
  app.use(
    '/docs',
    apiReference({
      spec: {
        content: document,
      },
      layout: 'modern',
      isEditable: false,
      metaData: {
        title: 'Plane Pal',
        description: 'Plane Pal API Documentation',
      },
    }),
  );
  await app.listen(process.env.PORT || 5000);
}
bootstrap();
