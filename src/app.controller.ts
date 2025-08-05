import { Controller, Get, Inject } from '@nestjs/common';
import { AppService } from './app.service';
import { ClientKafka, MessagePattern, Payload } from '@nestjs/microservices';
import { orderData } from '../types/order';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    @Inject('KAFKA_SERVICE_order') private readonly kafkaClient: ClientKafka,
  ) {}

  @MessagePattern('order_created')
  handleOrderCreated(@Payload() order: orderData): void {
    //Preciso implementar a lógica de processamento do pedido aqui
    this.kafkaClient.emit('process_payment', order);
    console.log('Pedido recebido:', order);
  }
}
