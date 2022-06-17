FROM maven:3.8.6-openjdk-11 as build
COPY . .
ENV JAVA_TOOL_OPTIONS="-Xmx4096m -Xms4096m"
RUN mvn package -e

FROM openjdk:11.0.1-jre-slim-stretch as run
EXPOSE 8080
ARG JAR=spring-petclinic-2.7.0-SNAPSHOT.jar
COPY --from=build target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
