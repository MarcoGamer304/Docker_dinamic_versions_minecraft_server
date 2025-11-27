#!/bin/sh

MAXRAM="${JVM_MIN_RAM:-12G}"
MINRAM="${JVM_MAX_RAM:-14G}"

# Aquí ya usamos MC_VERSION y FORGE_VERSION del Dockerfile
FORGE_VERSION=14.23.5.2859
MC_VERSION=1.12.2

# Arreglar online-mode
if [ -f server.properties ]; then
  sed -i 's/^online-mode=true/online-mode=false/' server.properties
else
  echo "online-mode=false" > server.properties
  echo "eula=true" > eula.txt
fi

# --- MODO LEGACY PARA 1.12.2 ---
if [ "$MC_VERSION" = "1.12.2" ]; then
  echo "=== Starting Forge 1.12.2 (legacy mode) ==="
  
  JAR="forge-${MC_VERSION}-${FORGE_VERSION}.jar"

  if [ ! -f "$JAR" ]; then
    echo "ERROR: No se encuentra $JAR"
    ls -la
    exit 1
  fi

  exec java -Xms${MAXRAM} -Xmx${MINRAM} -jar "$JAR" nogui
  exit 0
fi

# --- MODO MODERNO PARA 1.20+ ---
if [ ! -f run.sh ]; then
  echo "Forge installation failed."
  ls -la
  exit 1
fi

echo "=== Starting modern Forge $MC_VERSION-$FORGE_VERSION ==="
exec java -Xms${MAXRAM} -Xmx${MINRAM} @user_jvm_args.txt @libraries/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/unix_args.txt nogui