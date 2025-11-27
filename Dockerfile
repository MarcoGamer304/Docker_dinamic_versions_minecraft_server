FROM eclipse-temurin:8-jdk

WORKDIR /server

ARG FORGE_VERSION=14.23.5.2859
ARG MC_VERSION=1.12.2

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN echo "Downloading Forge $FORGE_VERSION" && \
    curl -s -o forge-installer.jar https://maven.minecraftforge.net/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar

RUN java -jar forge-installer.jar --installServer

COPY ./data/entrypoint.sh /server/entrypoint.sh
COPY ./data/server.properties /server/server.properties
COPY ./mods/ /server/mods/

RUN echo "eula=true" > eula.txt

RUN chmod +x /server/entrypoint.sh

EXPOSE 25565

ENTRYPOINT ["/server/entrypoint.sh"]
