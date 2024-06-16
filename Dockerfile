# Stage 1: Build the application
FROM maven:3.8.5-openjdk-11 AS builder
# Set the working directory
WORKDIR /app
# Copy the pom.xml file
COPY pom.xml .
# Copy the source code
COPY src ./src
# Build the application
RUN mvn clean package -DskipTests
# Stage 2: Run the application
FROM tomcat:9.0-jdk11-openjdk-slim
# Set the working directory
WORKDIR /usr/local/tomcat/webapps
# Copy all .war files from the builder stage
COPY --from=builder /app/target/*.war ./
# Expose the port on which the application runs
EXPOSE 8080
# Command to run the application
CMD ["catalina.sh", "run"]
