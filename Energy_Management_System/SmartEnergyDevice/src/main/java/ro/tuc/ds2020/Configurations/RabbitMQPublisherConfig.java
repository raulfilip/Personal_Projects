package ro.tuc.ds2020.Configurations;

import org.springframework.amqp.core.TopicExchange;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQPublisherConfig {

    @Bean
    public TopicExchange deviceExchange() {
        return new TopicExchange("device.change.exchange");
    }
}
