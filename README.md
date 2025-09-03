# 🎮 SERVIDOR MINECRAFT FORGE PROFESIONAL 1.20.1

¡Servidor de supervivencia con armas, mapas y optimización profesional!

## 📋 Información del Servidor

- **Versión de Minecraft**: 1.20.1
- **Forge Version**: 47.3.0
- **Java Version**: 17 (OpenJDK)
- **RAM Asignada**: 6GB máximo, 4GB mínimo (OPTIMIZADO)
- **Puerto**: 25565 (por defecto)
- **Modo**: Supervivencia
- **Dificultad**: Normal
- **Máximo de jugadores**: 20
- **Mods instalados**: 25 (Armas, Mapas, Optimización)
- **Configuración**: Profesional con G1GC y Aikar's flags

## 🚀 Cómo Iniciar el Servidor

### 🎆 **Método PROFESIONAL (Recomendado):**
```bash
# Gestor profesional con menú interactivo
./server_manager.sh

# O comandos directos:
./server_manager.sh start    # Iniciar servidor
./server_manager.sh stop     # Detener servidor  
./server_manager.sh backup   # Crear backup
./server_manager.sh status   # Ver estado
```

### Método Simple:
```bash
# Método directo
./start_server.sh

# Sin interfaz gráfica
./start_server.sh nogui
```

### 🚀 **DEPLOYMENT A VPS:**
```bash
# Deployment automático completo
./deploy_to_vps.sh
```

## ⚙️ Configuración

### Archivos Importantes:
- `server.properties` - Configuración principal del servidor
- `user_jvm_args.txt` - Configuración de memoria RAM
- `eula.txt` - Acuerdo de licencia (ya aceptado)
- `mods/` - Carpeta donde van los mods
- `world/` - Carpeta del mundo generado

### Configuración Actual:
- **Online mode**: Desactivado (para jugar sin cuenta premium)
- **PvP**: Activado
- **Command blocks**: Activados
- **Spawn protection**: 16 bloques
- **View distance**: 10 chunks
- **Simulation distance**: 10 chunks

## 📦 Instalación de Mods

⚠️ **IMPORTANTE**: Este servidor usa **MODS** (Forge), NO plugins (Bukkit/Spigot). Los mods son más potentes pero requieren que los jugadores también los tengan instalados.

1. Descarga los mods compatibles con **Minecraft 1.20.1** y **Forge 47.3.0**
2. Coloca los archivos `.jar` en la carpeta `mods/`
3. Reinicia el servidor
4. **TODOS los jugadores deben instalar los mismos mods** en su cliente

📋 **Guías disponibles:**
- `mods/README.md` - Lista general de mods
- `GUIA-MODS-SUPERVIVENCIA.md` - **Recomendado**: Pack específico para supervivencia con armas y mapas
- `mods-recomendados-supervivencia.md` - Detalles técnicos

## 👥 Gestión de Jugadores

### Comandos útiles desde la consola:
- `op <nombre>` - Dar permisos de operador a un jugador
- `deop <nombre>` - Quitar permisos de operador
- `whitelist add <nombre>` - Añadir jugador a la whitelist
- `whitelist remove <nombre>` - Quitar jugador de la whitelist
- `whitelist on/off` - Activar/desactivar whitelist
- `ban <nombre>` - Banear un jugador
- `kick <nombre>` - Expulsar un jugador
- `stop` - Detener el servidor de forma segura

## 🌐 Conexión de Jugadores

### Para conectarse al servidor:
1. **IP Local**: `localhost` o `127.0.0.1` (si juegas en la misma máquina)
2. **IP de Red Local**: La IP de tu PC en la red local (ej: `192.168.1.100`)
3. **IP Pública**: Tu IP pública + port forwarding del puerto 25565

### Configuración de Firewall:
Asegúrate de que el puerto 25565 esté abierto en tu firewall:
```bash
sudo ufw allow 25565
```

## 🔧 Resolución de Problemas

### El servidor no inicia:
- Verifica que Java 17 esté instalado
- Revisa que tengas suficiente RAM libre
- Comprueba los logs en la carpeta `logs/`

### Problemas de conexión:
- Verifica la configuración del firewall
- Confirma que el puerto 25565 esté abierto
- Revisa la IP y puerto en `server.properties`

### Problemas con mods:
- Asegúrate de que todos los mods sean compatibles con Minecraft 1.20.1
- Verifica que no haya conflictos entre mods
- Revisa los logs para errores específicos

## 📁 Estructura del Servidor

```
MCSERVER/
├── config/                 # Configuraciones de mods
├── defaultconfigs/         # Configuraciones por defecto
├── libraries/              # Librerías de Forge
├── logs/                   # Logs del servidor
├── mods/                   # Mods instalados
│   └── README.md          # Guía de mods
├── world/                  # Archivos del mundo
├── eula.txt               # Acuerdo de licencia
├── server.properties      # Configuración principal
├── start_server.sh        # Script de inicio (recomendado)
├── run.sh                 # Script original de Forge
├── user_jvm_args.txt      # Configuración de memoria
└── README.md              # Esta documentación
```

## 🚀 Preparación para VPS

Cuando estés listo para subir el servidor a tu VPS:

1. **Comprime toda la carpeta**:
   ```bash
   tar -czf minecraft-server.tar.gz MCSERVER/
   ```

2. **Sube al VPS** usando SCP o similar
3. **Instala Java 17** en el VPS
4. **Configura el firewall** para el puerto 25565
5. **Ejecuta el servidor** con `./start_server.sh nogui`

📄 **DOCUMENTACIÓN PROFESIONAL**

- **`ADMIN-GUIDE.md`** - 🔥 **GUÍA COMPLETA DE ADMINISTRACIÓN**
- **`GUIA-MODS-SUPERVIVENCIA.md`** - Pack de mods para supervivencia
- **`mods-recomendados-supervivencia.md`** - Lista detallada de mods
- **`mods/README.md`** - Información general de mods

## 🎆 **CARACTERÍSTICAS PROFESIONALES**

✅ **Gestor profesional** con menú interactivo  
✅ **Backups automáticos** con retención inteligente  
✅ **Monitor en tiempo real** del servidor  
✅ **Deployment automático** a VPS  
✅ **Optimización avanzada** de JVM (G1GC + Aikar's flags)  
✅ **25 mods cuidadosamente seleccionados**  
✅ **Configuración de seguridad** y firewall  
✅ **Servicio systemd** para VPS  
✅ **Scripts de emergencia** y recuperación  

## 📝 Notas Adicionales

- Haz respaldos regulares usando `./server_manager.sh backup`
- Monitorea el rendimiento con `./server_manager.sh monitor`  
- Para VPS, usa el deployment automático `./deploy_to_vps.sh`
- Consulta `ADMIN-GUIDE.md` para administración avanzada

---

**🎆 ¡Tu servidor PROFESIONAL de Minecraft está listo!** 🎆

*Configuración profesional completa - Listo para producción y VPS*
