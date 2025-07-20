FROM openjdk:21-jdk-slim

WORKDIR /server

ARG FORGE_VERSION=57.0.3
ARG MC_VERSION=1.21.7

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN echo "Downloading Forge $FORGE_VERSION" && \
    curl -s -o forge-installer.jar https://maven.minecraftforge.net/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar

RUN java -jar forge-installer.jar --installServer

COPY ./data/entrypoint.sh /server/entrypoint.sh
COPY ./data/server.properties /server/server.properties

RUN echo "eula=true" > eula.txt

RUN chmod +x /server/entrypoint.sh

EXPOSE 25565

ENTRYPOINT ["/server/entrypoint.sh"]
