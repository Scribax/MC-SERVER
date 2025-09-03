#!/bin/bash

# Script para descargar mods esenciales para servidor de supervivencia
# Minecraft 1.20.1 - Forge 47.3.0

echo "🎮 Descargando mods esenciales para servidor de supervivencia..."
echo "Versión: Minecraft 1.20.1 - Forge 47.3.0"
echo ""

# Crear carpeta de descarga temporal
mkdir -p temp_mods
cd temp_mods

echo "📥 Descargando mods de optimización..."

# FerriteCore (Optimización de RAM)
echo "⚡ Descargando FerriteCore..."
curl -L -o "ferritecore-6.0.1-forge.jar" "https://cdn.modrinth.com/data/uXXizFIs/versions/kwjHqfz8/ferritecore-6.0.1-forge.jar"

# Clumps (Optimización XP)
echo "⚡ Descargando Clumps..."
curl -L -o "Clumps-forge-1.20.1-12.0.0.4.jar" "https://cdn.modrinth.com/data/Wnxd13zP/versions/IAnP6WgQ/Clumps-forge-1.20.1-12.0.0.4.jar"

echo ""
echo "🗺️ Descargando mods de navegación..."

# JEI (Just Enough Items)
echo "🔍 Descargando JEI..."
curl -L -o "jei-1.20.1-forge-15.2.0.27.jar" "https://cdn.modrinth.com/data/u6dRKJwZ/versions/15.2.0.27/jei-1.20.1-forge-15.2.0.27.jar"

echo ""
echo "⚔️ Para descargar mods de armas y mapas, visita estos links:"
echo ""
echo "🗺️ MAPAS (ELIGE UNO):"
echo "   JourneyMap: https://www.curseforge.com/minecraft/mc-mods/journeymap/files"
echo "   Xaero's Minimap: https://www.curseforge.com/minecraft/mc-mods/xaeros-minimap/files"
echo ""
echo "⚔️ ARMAS (RECOMENDADOS):"
echo "   Simply Swords: https://www.curseforge.com/minecraft/mc-mods/simply-swords-forge/files"
echo "   Spartan Weapons: https://www.curseforge.com/minecraft/mc-mods/spartan-weapons/files"
echo ""
echo "🏗️ SUPERVIVENCIA:"
echo "   Corpse: https://www.curseforge.com/minecraft/mc-mods/corpse/files"
echo "   WAILA: https://www.curseforge.com/minecraft/mc-mods/hwyla/files"
echo ""

# Mover mods descargados a la carpeta principal
echo "📁 Moviendo mods descargados a la carpeta mods/..."
mv *.jar ../mods/ 2>/dev/null

# Limpiar
cd ..
rmdir temp_mods 2>/dev/null

echo ""
echo "✅ Mods de optimización básicos descargados!"
echo ""
echo "📋 PRÓXIMOS PASOS:"
echo "1. Descarga manualmente los mods de armas y mapas desde los links de arriba"
echo "2. Busca archivos para Minecraft 1.20.1 y Forge"
echo "3. Coloca los archivos .jar en la carpeta mods/"
echo "4. Reinicia el servidor con: ./start_server.sh"
echo ""
echo "💡 CONSEJO: Empieza con pocos mods y añade más gradualmente para probar estabilidad"
