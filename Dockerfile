FROM amazoncorretto






ADD .  /app

WORKDIR /app
EXPOSE 8085

CMD ["java", "-jar", "/app/target/sample.jar"]
