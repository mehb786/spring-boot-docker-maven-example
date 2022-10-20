FROM maven as base
WORKDIR /app
COPY . .
RUN mvn clean package


FROM amazancorretto
WORKDIR /app
COPY --from=base /app/target/*.jar .
EXPOSE 8000
CMD ["java","-jar","sample.jar"]
