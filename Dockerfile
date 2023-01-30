# Java 17 base
FROM eclipse-temurin:17

# TODO: Environment variables


RUN apt update && apt install -y wget
RUN mkdir -p /server
WORKDIR /server

# Download Minecraft server
RUN wget "https://api.papermc.io/v2/projects/paper/versions/1.19.3/builds/386/downloads/paper-1.19.3-386.jar" -O server.jar
RUN wget "https://github.com/yushijinhun/authlib-injector/releases/download/v1.2.1/authlib-injector-1.2.1.jar" -O authlib-injector.jar
RUN echo "eula=true" > eula.txt

# Run server
CMD ["java", "-javaagent:authlib-injector.jar=ely.by", "-Dauthlibinjector.mojangNamespace=disabled", "-jar", "server.jar"]
