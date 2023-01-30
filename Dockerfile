FROM openjdk:8-jdk-alpine
EXPOSE 8089
ADD target/my-app-1.jar my-app-1.jar
ENTRYPOINT ["java","-jar","/my-app-1.jar"]
