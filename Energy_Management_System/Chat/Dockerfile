FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and package the application (skip tests)
COPY src ./src
RUN mvn clean package -DskipTests=true

# Use a lightweight JDK image to run the application
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port specified in application.properties
EXPOSE 8082

# Set environment variables for the database
ENV DB_IP=localhost
ENV DB_PORT=3306
ENV DB_USER=root
ENV DB_PASSWORD=root1234
ENV DB_DBNAME=chat

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
