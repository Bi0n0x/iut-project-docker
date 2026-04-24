# Stage 1 : build de l'application
FROM eclipse-temurin:25-jdk AS builder

WORKDIR /app
COPY . .

RUN chmod +x gradlew && ./gradlew build -x test --no-daemon

# Stage 2 : création d'un JRE minimal avec jlink
FROM eclipse-temurin:25-jdk AS jre-builder

RUN $JAVA_HOME/bin/jlink \
    --add-modules java.base,java.naming,java.logging,java.management,java.security.jgss,java.desktop,java.xml,java.instrument \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /custom-jre

# Stage 3 : image finale minimale
FROM debian:stable-slim

ENV JAVA_HOME=/opt/jre
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jre-builder /custom-jre $JAVA_HOME
COPY --from=builder /app/build/libs/app.jar /app/app.jar

WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
