FROM eclipse-temurin:25-jdk-alpine AS builder
WORKDIR /builder

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} application.jar

RUN java -Djarmode=tools -jar application.jar extract --layers --destination extracted

FROM eclipse-temurin:25-jre-alpine AS runtime
WORKDIR /application

COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./

RUN java -XX:AOTCacheOutput=application.aot -Dspring.context.exit=onRefresh -Dspring.profiles.active=aot -jar application.jar

ENTRYPOINT ["java", "-XX:AOTCache=application.aot", "-jar", "application.jar"]