#!/bin/sh

MAXRAM="${JVM_MIN_RAM:-2G}"
MINRAM="${JVM_MAX_RAM:-4G}"

FORGE_VERSION="${FORGE_VERSION:-57.0.3}"
MC_VERSION="${MC_VERSION:-1.21.7}"

if [ -f server.properties ]; then
  echo "Estableciendo 'online-mode=false' en server.properties"
  sed 's/^online-mode=true/online-mode=false/' server.properties > /tmp/server.properties.edit
  cat /tmp/server.properties.edit > server.properties
  rm /tmp/server.properties.edit
else
  echo "server.properties not found, creating one..."
  echo "online-mode=false" > server.properties
  echo "eula=true" >> eula.txt
fi

if [ ! -f run.sh ]; then
  echo "Forge installation failed."
  ls -la
  exit 1
fi

echo "Server running with ${MINRAM} and ${MAXRAM} of RAM..."
#exec bash run.sh
exec java -Xms${MAXRAM} -Xmx${MINRAM} @user_jvm_args.txt @libraries/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/unix_args.txt nogui