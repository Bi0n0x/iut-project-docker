# Stage 1 : build avec le JDK complet
FROM eclipse-temurin:25-jdk AS builder

WORKDIR /app
COPY . .

RUN chmod +x gradlew && ./gradlew build -x test --no-daemon

# Stage 2 : runtime avec JRE seulement
FROM eclipse-temurin:25-jre

WORKDIR /app
COPY --from=builder /app/build/libs/app.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
