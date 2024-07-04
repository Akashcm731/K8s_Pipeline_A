FROM maven:amazoncorretto as build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM artisantek/tomcat:1
RUN useradd -ms /bin/bash admin
RUN chown -R admin: /app /usr/local/tomcat/webapps
USER acm
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
