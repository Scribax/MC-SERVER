# 🎯 GUÍA COMPLETA: Mods para Servidor de Supervivencia con Armas y Mapas

## 🚀 **PACK RECOMENDADO PARA TU SERVIDOR**

### 📦 **PACK BÁSICO (5 mods esenciales)**
**Perfecto para empezar - Muy estable**

1. **🗺️ JourneyMap** - Para navegación y minimapa
2. **⚔️ Simply Swords** - 100+ espadas épicas
3. **⚡ FerriteCore** - Optimización de RAM (40% menos uso)
4. **⚡ Clumps** - Optimización de XP
5. **🔍 JEI** - Interfaz de recetas mejorada

### 📦 **PACK COMPLETO (10 mods recomendados)**
**Para la experiencia completa**

6. **⚔️ Spartan Weapons** - Lanzas, katanas, dagas, etc.
7. **💀 Corpse** - No pierdes items al morir
8. **🔍 WAILA/HWYLA** - Info de bloques al apuntarlos
9. **⚡ AI Improvements** - Optimización de mobs
10. **🏃 Combat Roll** - Mecánicas de combate mejoradas

---

## 📥 **CÓMO DESCARGAR LOS MODS**

### **Opción 1: CurseForge (Recomendado)**

Ve a cada enlace y descarga la versión para **Minecraft 1.20.1** y **Forge**:

#### 🗺️ **MAPAS (ELIGE UNO)**
- **JourneyMap**: https://www.curseforge.com/minecraft/mc-mods/journeymap/files
  - Busca: `journeymap-1.20.1-5.9.21-forge.jar`
- **Alternativa - Xaero's Minimap**: https://www.curseforge.com/minecraft/mc-mods/xaeros-minimap/files
  - Busca: `Xaeros_Minimap_23.8.0_Forge_1.20.jar`

#### ⚔️ **ARMAS**
- **Simply Swords**: https://www.curseforge.com/minecraft/mc-mods/simply-swords-forge/files
  - Busca: `simplyswords-forge-1.54.0-1.20.1.jar`
- **Spartan Weapons**: https://www.curseforge.com/minecraft/mc-mods/spartan-weapons/files
  - Busca: `SpartanWeaponry-1.20.1-3.1.3.jar`

#### ⚡ **OPTIMIZACIÓN**
- **FerriteCore**: https://www.curseforge.com/minecraft/mc-mods/ferritecore/files
  - Busca: `ferritecore-6.0.1-forge.jar`
- **Clumps**: https://www.curseforge.com/minecraft/mc-mods/clumps/files
  - Busca: `Clumps-forge-1.20.1-12.0.0.4.jar`
- **AI Improvements**: https://www.curseforge.com/minecraft/mc-mods/ai-improvements/files
  - Busca: `AIImprovements-1.20.1-0.5.2.jar`

#### 🏗️ **CALIDAD DE VIDA**
- **JEI**: https://www.curseforge.com/minecraft/mc-mods/jei/files
  - Busca: `jei-1.20.1-forge-15.2.0.27.jar`
- **Corpse**: https://www.curseforge.com/minecraft/mc-mods/corpse/files
  - Busca: `corpse-1.20.1-1.0.14.jar`
- **WAILA**: https://www.curseforge.com/minecraft/mc-mods/hwyla/files
  - Busca: `Hwyla-forge-1.20.1-1.4.3.jar`
- **Combat Roll**: https://www.curseforge.com/minecraft/mc-mods/combat-roll/files
  - Busca: `combatroll-forge-1.20.1-1.3.3.jar`

---

## 📋 **INSTALACIÓN PASO A PASO**

### **1. Descarga los mods**
- Ve a cada enlace de arriba
- Busca la sección "Files"
- Descarga la versión para **Minecraft 1.20.1**
- Asegúrate que diga **Forge** (no Fabric)

### **2. Instala los mods**
```bash
# Desde tu carpeta MCSERVER
cd mods/

# Mueve todos los archivos .jar descargados aquí
# Por ejemplo:
mv ~/Downloads/*.jar .
```

### **3. Verifica la instalación**
```bash
ls -la mods/
# Deberías ver archivos .jar, no archivos de texto
```

### **4. Inicia el servidor**
```bash
./start_server.sh
```

---

## ⚠️ **PROBLEMAS COMUNES**

### **"El mod no es compatible"**
- Verifica que sea para Minecraft **1.20.1** exactamente
- Asegúrate que sea para **Forge**, no Fabric

### **"El servidor no inicia"**
- Revisa los logs en la carpeta `logs/`
- Prueba removiendo el último mod añadido
- Algunos mods requieren dependencias

### **"Archivo muy pequeño"**
- Si un .jar es menor a 100KB, probablemente se descargó mal
- Re-descarga desde el link oficial

---

## 🔧 **CONFIGURACIÓN RECOMENDADA**

### **Para JourneyMap** (después de instalarlo):
- Permite waypoints compartidos
- Habilita minimapa para todos
- Configura en `config/journeymap/`

### **Para Simply Swords**:
- Las armas aparecen automáticamente en JEI
- Se pueden craftear con materiales vanilla

### **Para Corpse**:
- Al morir, aparece un cuerpo con tus items
- Click derecho para recuperar todo

---

## 🎮 **CÓMO JUGAR**

### **Para los jugadores:**
1. **Instalar Forge** en su cliente de Minecraft
2. **Descargar los mismos mods** que tiene el servidor
3. **Colocar en su carpeta** `mods/` local
4. **Conectar al servidor**

### **Comandos útiles:**
- `F7` - Mostrar/ocultar minimapa (JourneyMap)
- `J` - Abrir mapa completo (JourneyMap)
- `B` - Crear waypoint (JourneyMap)
- `R` - Ver receta (JEI)
- `U` - Ver usos (JEI)

---

## 📊 **RENDIMIENTO ESPERADO**

### **Con optimización (FerriteCore + Clumps + AI Improvements):**
- **RAM**: 30-40% menos uso
- **CPU**: 15-20% menos uso
- **TPS**: Más estable
- **Lag**: Notablemente reducido

### **Con el pack completo:**
- **Jugadores simultáneos**: 10-15 cómodamente
- **Chunks cargados**: Más eficiente
- **Tiempo de inicio**: ~2-3 minutos

---

## 🚀 **SIGUIENTES PASOS**

1. **Empieza con el pack básico** (5 mods)
2. **Prueba estabilidad** con tus amigos
3. **Añade más mods** gradualmente
4. **Haz backup** antes de añadir mods nuevos

---

**¡Tu servidor de supervivencia épico te está esperando!** ⚔️🗺️
