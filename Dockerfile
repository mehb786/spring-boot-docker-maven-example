FROM amazoncorretto






ADD .  /app

WORKDIR /app
EXPOSE 8085

CMD ["java", "-jar", "/root/slave/workspace/target/sample.jar"]
