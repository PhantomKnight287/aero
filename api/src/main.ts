import 'dotenv/config';
import { writeFileSync } from 'fs';
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
  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });
  app.useGlobalPipes(
    new ValidationPipe({ whitelist: true, enableDebugMessages: true }),
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
