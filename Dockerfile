FROM eclipse-temurin:25-jdk

WORKDIR /app
COPY . .

RUN chmod +x gradlew && ./gradlew build -x test --no-daemon

EXPOSE 8080
CMD ["java", "-jar", "build/libs/app.jar"]
