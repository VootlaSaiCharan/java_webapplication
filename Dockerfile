FROM maven AS build

# Created a work directory
WORKDIR /app

# Copy files  from the current directory to the work directory
COPY . /app

# Build the  application
RUN mvn clean install

#  Copy the war file into the work directory
COPY target/webapplication-0.0.1-SNAPSHOT.war /app/myapp.war

FROM tomcat

# Removing the Previous files
RUN rm -rf /usr/local/tomcat/webapps/*

#  Copy the war file to the tomcat webapps directory
COPY --from=build /app/myapp.war /usr/local/tomcat/webapps/ROOT.war

# Start the Tomcat server
CMD ["catalina.sh", "run"]

# Exposing the Port
EXPOSE 80
