# 🎛️ GUÍA DE ADMINISTRACIÓN PROFESIONAL
## Servidor Minecraft Forge 1.20.1

---

## 📋 **RESUMEN EJECUTIVO**

Este servidor está configurado profesionalmente con:
- **25 mods cuidadosamente seleccionados** para supervivencia, armas y navegación
- **Optimizaciones avanzadas de JVM** (G1GC, Aikar's flags)
- **Sistema de gestión automatizada** con backups y monitoreo
- **Scripts de deployment** para VPS listos para producción
- **Configuración de seguridad** y firewall automático

---

## 🚀 **INICIO RÁPIDO**

### **Localmente:**
```bash
# Método profesional (recomendado)
./server_manager.sh

# O método directo
./start_server.sh
```

### **En VPS:**
```bash
# Deployment completo automático
./deploy_to_vps.sh

# O comando directo
./deploy_to_vps.sh full
```

---

## 🎛️ **HERRAMIENTAS DE ADMINISTRACIÓN**

### **1. Gestor Principal: `server_manager.sh`**
**El centro de control profesional del servidor.**

```bash
# Uso interactivo (recomendado)
./server_manager.sh

# Comandos directos
./server_manager.sh start      # Iniciar servidor
./server_manager.sh stop       # Detener servidor
./server_manager.sh restart    # Reiniciar servidor
./server_manager.sh backup     # Crear backup
./server_manager.sh status     # Ver estado
./server_manager.sh console    # Conectar a consola
```

**Características:**
- ✅ Interfaz colorizada y profesional
- ✅ Avisos automáticos a jugadores antes de restart
- ✅ Backups automáticos con limpieza
- ✅ Monitoreo en tiempo real
- ✅ Gestión de logs
- ✅ Información del sistema

### **2. Deployment: `deploy_to_vps.sh`**
**Deployment automático a VPS con un solo comando.**

```bash
# Deployment completo
./deploy_to_vps.sh

# Opciones rápidas
./deploy_to_vps.sh full     # Deployment completo
./deploy_to_vps.sh upload   # Solo subir archivos
```

**Características:**
- ✅ Instalación automática de dependencias
- ✅ Configuración de firewall automática
- ✅ Creación de usuario `minecraft`
- ✅ Servicio systemd automático
- ✅ Verificación post-deployment

---

## ⚙️ **CONFIGURACIÓN PROFESIONAL**

### **Memoria y JVM (`user_jvm_args.txt`):**
```bash
# Configuración actual (6GB RAM)
-Xmx6G -Xms4G

# Para VPS con menos RAM (4GB)
-Xmx4G -Xms2G

# Para VPS con más RAM (8GB+)
-Xmx8G -Xms4G
```

**Optimizaciones incluidas:**
- G1 Garbage Collector optimizado
- Aikar's flags para servidores
- Configuración de red optimizada
- Parámetros de latencia reducida

### **Servidor (`server.properties`):**
```properties
# Configuración optimizada para producción
max-players=20
view-distance=12
simulation-distance=8
network-compression-threshold=512
sync-chunk-writes=false  # Mejor rendimiento
online-mode=false        # Para cuentas no premium
```

---

## 🗺️ **MODS INSTALADOS**

### **📊 Resumen:**
- **Total de mods:** 25
- **Categorías:** Navegación, Armas, Optimización, Supervivencia
- **Tamaño total:** ~80MB
- **Rendimiento:** Optimizado para 10-20 jugadores

### **🎯 Mods Clave:**

#### **Navegación y Mapas:**
- **JourneyMap** - Minimapa profesional con waypoints
- **Xaero's Minimap** - Alternativa ligera (si prefieres)

#### **Armas y Combate:**
- **Simply Swords** - 100+ espadas únicas
- **Just Enough Guns** - Arsenal de armas de fuego
- **Spartan Weapons** - Armas medievales

#### **Optimización:**
- **Embeddium** - Optimización de renderizado
- **Spark** - Profiler de rendimiento integrado
- **Clumps** - Optimización de XP

#### **Supervivencia Mejorada:**
- **Corpse** - Sistema de muerte sin pérdida
- **Farmer's Delight** - Sistema de cocina avanzado
- **Alex's Mobs** - 70+ criaturas nuevas

---

## 💾 **SISTEMA DE BACKUPS**

### **Backups Automáticos:**
```bash
# Crear backup manual
./server_manager.sh backup

# Los backups se guardan en:
backups/world_backup_YYYYMMDD_HHMMSS.tar.gz
```

### **Política de Backups:**
- ✅ **Automático:** Antes de cada restart
- ✅ **Retención:** 10 backups más recientes
- ✅ **Compresión:** tar.gz para ahorrar espacio
- ✅ **Seguridad:** Backups con servidor en ejecución

### **Restaurar Backup:**
```bash
# Detener servidor
./server_manager.sh stop

# Respaldar mundo actual
mv world world_old

# Restaurar backup
cd backups
tar -xzf world_backup_FECHA.tar.gz
mv world ../

# Reiniciar servidor
cd ..
./server_manager.sh start
```

---

## 📊 **MONITOREO Y RENDIMIENTO**

### **Monitor en Tiempo Real:**
```bash
# Monitor continuo
./server_manager.sh
# Opción 7: Monitor continuo

# Ver logs en tiempo real
./server_manager.sh
# Opción 6: Ver logs en tiempo real
```

### **Métricas Importantes:**
- **TPS (Ticks Per Second):** Debe mantenerse en 20
- **RAM:** Máximo 6GB, óptimo 4-5GB
- **CPU:** Depende del número de jugadores
- **Jugadores:** 15-20 cómodamente

### **Spark Profiler (Mod incluido):**
```bash
# En la consola del servidor:
/spark profiler start
/spark profiler stop
/spark profiler web
```

---

## 🔐 **SEGURIDAD Y ADMINISTRACIÓN**

### **Comandos de Administración:**
```bash
# En consola del servidor o como OP:
op <usuario>              # Dar permisos de admin
deop <usuario>            # Quitar permisos
whitelist add <usuario>   # Añadir a whitelist
whitelist on/off         # Activar/desactivar whitelist
ban <usuario>            # Banear jugador
kick <usuario>           # Expulsar jugador
```

### **Firewall (VPS):**
```bash
# Puerto del servidor
ufw allow 25565/tcp

# SSH (no cerrar)
ufw allow OpenSSH

# Activar firewall
ufw enable
```

---

## 🌐 **DEPLOYMENT A VPS**

### **Requisitos del VPS:**
- **RAM:** Mínimo 6GB (recomendado 8GB)
- **CPU:** 2+ cores (recomendado 4+ cores)
- **Disco:** 20GB+ libres
- **OS:** Ubuntu 20.04+, CentOS 8+, Debian 10+

### **Proceso Automático:**
```bash
# 1. Ejecutar script de deployment
./deploy_to_vps.sh

# 2. Seguir el asistente de configuración
# - IP del VPS
# - Usuario SSH
# - Puerto SSH (default: 22)
# - Directorio remoto (default: /opt/minecraft)

# 3. El script hace todo automáticamente:
# - Instala Java 17
# - Instala dependencias
# - Configura firewall
# - Crea usuario minecraft
# - Sube archivos
# - Configura servicio systemd

# 4. ¡Servidor listo!
```

### **Gestión en VPS:**
```bash
# Conectar al VPS
ssh usuario@IP_VPS

# Cambiar al directorio
cd /opt/minecraft

# Gestionar servidor
sudo -u minecraft ./server_manager.sh

# Ver estado como servicio
systemctl status minecraft
systemctl start minecraft
systemctl stop minecraft
```

---

## 🐛 **RESOLUCIÓN DE PROBLEMAS**

### **Problemas Comunes:**

#### **Servidor no inicia:**
```bash
# 1. Verificar Java
java -version  # Debe ser 17+

# 2. Verificar memoria
free -h  # Debe tener suficiente RAM libre

# 3. Ver logs
tail -f logs/latest.log
```

#### **Lag o baja TPS:**
```bash
# 1. Usar Spark profiler
/spark profiler start
# Esperar 30 segundos
/spark profiler stop
/spark profiler web

# 2. Reducir view-distance
# En server.properties: view-distance=10

# 3. Verificar mods problemáticos
# Quitar mods uno por uno para identificar el problema
```

#### **Problemas de conexión:**
```bash
# 1. Verificar puerto
netstat -tulpn | grep 25565

# 2. Verificar firewall
ufw status
iptables -L

# 3. Verificar IP externa
curl ifconfig.me
```

---

## 📈 **ESCALABILIDAD**

### **Para más jugadores (20+):**
```bash
# Aumentar RAM
-Xmx8G -Xms4G

# Optimizar server.properties
max-players=30
view-distance=10
simulation-distance=6
```

### **Para mejor rendimiento:**
```bash
# Añadir mods de optimización
# - FerriteCore
# - LazyDFU  
# - Lithium (si es compatible)

# Usar SSD para almacenamiento
# Configurar VPS con más CPU cores
```

---

## 📞 **COMANDOS DE EMERGENCIA**

```bash
# Detener servidor inmediatamente
pkill -f "java.*forge"

# Reinicio forzado
./server_manager.sh stop
killall screen
./server_manager.sh start

# Backup de emergencia
tar -czf emergency_backup_$(date +%Y%m%d_%H%M%S).tar.gz world/

# Conectar a consola perdida
screen -r minecraft_server

# Ver procesos del servidor
ps aux | grep java
```

---

## 🎯 **MEJORES PRÁCTICAS**

### **Mantenimiento Regular:**
- ✅ **Backups:** Cada vez antes de añadir mods
- ✅ **Updates:** Mantener mods actualizados
- ✅ **Limpieza:** Usar la opción de limpieza del gestor
- ✅ **Monitoreo:** Revisar rendimiento semanalmente

### **Gestión de Jugadores:**
- ✅ **Whitelist:** Usar en servidores privados
- ✅ **OPs:** Solo dar permisos a administradores de confianza
- ✅ **Reglas:** Establecer reglas claras del servidor

### **Seguridad:**
- ✅ **SSH Keys:** Usar en lugar de passwords
- ✅ **Firewall:** Mantener activado y configurado
- ✅ **Updates:** Mantener el sistema actualizado

---

## 🔧 **PERSONALIZACIÓN AVANZADA**

### **Añadir más mods:**
```bash
# 1. Descargar mod compatible (1.20.1 + Forge)
# 2. Colocar en carpeta mods/
# 3. Reiniciar servidor
./server_manager.sh restart
```

### **Configurar mods específicos:**
```bash
# Los archivos de configuración están en:
config/                    # Configuraciones de mods
defaultconfigs/            # Configuraciones por defecto
world/serverconfig/        # Configuraciones por mundo
```

---

**🎮 ¡Tu servidor profesional está listo para la acción!**

*Para soporte adicional, consulta los logs y usa las herramientas de monitoreo incluidas.*
