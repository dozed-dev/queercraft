# Java 17 base
FROM eclipse-temurin:17

# TODO: Environment variables

RUN apt update && apt install -y wget
WORKDIR /server

# Download Minecraft server

# Parer
#RUN wget "https://api.papermc.io/v2/projects/paper/versions/1.19.3/builds/386/downloads/paper-1.19.3-386.jar" -O server.jar

# Fabric
RUN wget "https://meta.fabricmc.net/v2/versions/loader/1.19.3/0.14.14/0.11.1/server/jar" -O server.jar

# Authlib injector
RUN wget "https://github.com/yushijinhun/authlib-injector/releases/download/v1.2.1/authlib-injector-1.2.1.jar" -O authlib-injector.jar

WORKDIR /server-data

# Should agree to EULA before running the server
#echo "eula=true" > eula.txt
# via compose:
#docker compose run mc-server bash -c 'echo "eula=true" > eula.txt'

# Run server
CMD ["java", "-javaagent:/server/authlib-injector.jar=ely.by", "-Dauthlibinjector.mojangNamespace=disabled", "-jar", "/server/server.jar", "nogui"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /server-data
