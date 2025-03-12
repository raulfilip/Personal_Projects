# Use an official Maven image to build the application
FROM maven:3.9.4-eclipse-temurin-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Build the application (skip tests)
RUN mvn clean package -DskipTests=true

# Use a lightweight OpenJDK runtime image to run the application
FROM eclipse-temurin:17-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application's port
EXPOSE 8081

# Environment variables for database and RabbitMQ configuration
ENV DB_IP=localhost \
    DB_PORT=3306 \
    DB_USER=root \
    DB_PASSWORD=root1234 \
    DB_DBNAME=user \
    PORT=8081 \
    SPRING_RABBITMQ_HOST=localhost \
    SPRING_RABBITMQ_PORT=5672 \
    SPRING_RABBITMQ_USERNAME=guest \
    SPRING_RABBITMQ_PASSWORD=guest

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
