import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const maxRetries = 10;
  let retries = 0;

  while (retries < maxRetries) {
    try {
          const app = await NestFactory.createMicroservice<MicroserviceOptions>(
        AppModule,
        {
          transport: Transport.KAFKA,
          options: {
            client: {
              brokers: ['kafka:29092'],
            },
            consumer: {
              groupId: 'order-consumer-group',
            },
          },
        },
      );

      await app.listen();
      console.log('Order service operante');

      break;
    } catch (error) {
      console.error(`Erro ao conectar ao Kafka. Tentativa ${retries + 1} de ${maxRetries}`);
      retries++;
      await new Promise((res) => setTimeout(res, 5000)); // espera 5 segundos
    }
  }

  if (retries === maxRetries) {
    console.error('Não foi possível conectar ao Kafka após várias tentativas.');
    process.exit(1);
  }
}
bootstrap();
