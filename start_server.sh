#!/bin/bash

# Script de inicio del servidor Minecraft Forge 1.20.1
# Utiliza Java 17 específicamente para compatibilidad

echo "Iniciando servidor Minecraft Forge 1.20.1..."
echo "Usando Java 17 para compatibilidad..."

# Usar Java 17 específicamente
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Verificar que estamos usando Java 17
echo "Versión de Java utilizada:"
java -version

echo ""
echo "Iniciando servidor..."
echo "Para detener el servidor, escribe 'stop' en la consola"
echo ""

# Ejecutar el servidor con Java 17
$JAVA_HOME/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.3.0/unix_args.txt "$@"
