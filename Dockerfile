FROM maven:3.8.4-openjdk-17 AS buildstage

WORKDIR /app

COPY . .

RUN mvn package

FROM openjdk:17 AS runstage

COPY --from=buildstage /app/target/spring-petclinic-rest-3.2.5.jar .

EXPOSE 9966

RUN groupadd spring

RUN adduser -r -g spring spring

USER spring

ENTRYPOINT ["java", "-jar", "spring-petclinic-rest-3.2.5.jar"]
