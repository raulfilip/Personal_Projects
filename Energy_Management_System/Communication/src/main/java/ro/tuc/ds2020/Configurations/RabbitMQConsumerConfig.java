package ro.tuc.ds2020.Configurations;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConsumerConfig {

    @Bean
    public TopicExchange deviceExchange() {
        return new TopicExchange("device.change.exchange");
    }

    @Bean
    public Queue updateQueue() {
        return new Queue("device.update.queue", true);
    }

    @Bean
    public Binding updateBinding(TopicExchange deviceExchange, Queue updateQueue) {
        return BindingBuilder.bind(updateQueue).to(deviceExchange).with("device.update");
    }

    @Bean
    public Queue deleteQueue() {
        return new Queue("device.delete.queue", true);
    }

    @Bean
    public Binding deleteBinding(TopicExchange deviceExchange, Queue deleteQueue) {
        return BindingBuilder.bind(deleteQueue).to(deviceExchange).with("device.delete");
    }

    @Bean
    public Queue energyQueue() {
        return new Queue("energy-queue", true);  // true for durable
    }

}
