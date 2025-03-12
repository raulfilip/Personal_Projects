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
EXPOSE 8084

# Environment variables for database and RabbitMQ configuration
ENV DB_IP=localhost \
    DB_PORT=3306 \
    DB_USER=root \
    DB_PASSWORD=root1234 \
    DB_DBNAME=communication \
    RABBITMQ_HOST=localhost \
    RABBITMQ_PORT=5672 \
    RABBITMQ_USERNAME=guest \
    RABBITMQ_PASSWORD=guest \
    PORT=8084

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
