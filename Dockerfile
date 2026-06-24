FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn compile exec:java

FROM nginx:alpine
COPY --from=builder /app/output /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
