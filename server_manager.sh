#!/bin/bash

# ===================================================================
# GESTOR PROFESIONAL DE SERVIDOR MINECRAFT FORGE 1.20.1
# Versión: 2.0
# ===================================================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuración
JAVA_HOME=/usr/lib/jvm/java-17-openjdk
SERVER_DIR=$(pwd)
BACKUP_DIR="$SERVER_DIR/backups"
WORLD_DIR="$SERVER_DIR/world"
LOG_FILE="$SERVER_DIR/server_manager.log"
SCREEN_NAME="minecraft_server"

# Función de logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Banner
show_banner() {
    echo -e "${PURPLE}=================================================================${NC}"
    echo -e "${CYAN}    🎮 GESTOR PROFESIONAL DE SERVIDOR MINECRAFT FORGE 1.20.1    ${NC}"
    echo -e "${PURPLE}=================================================================${NC}"
    echo ""
}

# Verificar dependencias
check_dependencies() {
    echo -e "${BLUE}🔍 Verificando dependencias...${NC}"
    
    if ! command -v screen &> /dev/null; then
        echo -e "${RED}❌ Screen no está instalado. Instalando...${NC}"
        sudo pacman -S screen
    fi
    
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        echo -e "${GREEN}✅ Directorio de backups creado${NC}"
    fi
    
    echo -e "${GREEN}✅ Dependencias verificadas${NC}"
    echo ""
}

# Función para mostrar estado del servidor
show_status() {
    echo -e "${BLUE}📊 Estado del Servidor:${NC}"
    echo "================================"
    
    if screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "Estado: ${GREEN}🟢 EJECUTÁNDOSE${NC}"
        echo "Screen: $SCREEN_NAME"
        
        # Mostrar uso de RAM
        if command -v ps &> /dev/null; then
            RAM_USAGE=$(ps aux | grep '[j]ava.*forge' | awk '{sum += $6} END {print sum/1024 " MB"}')
            echo "RAM: $RAM_USAGE"
        fi
        
        # Mostrar jugadores conectados
        if [ -f "logs/latest.log" ]; then
            PLAYERS=$(tail -n 100 logs/latest.log | grep "joined the game" | wc -l)
            echo "Jugadores recientes: $PLAYERS"
        fi
    else
        echo -e "Estado: ${RED}🔴 DETENIDO${NC}"
    fi
    
    echo "Puerto: $(grep '^server-port=' server.properties | cut -d'=' -f2)"
    echo "Mods instalados: $(ls mods/*.jar 2>/dev/null | wc -l)"
    echo "Último backup: $(ls -t backups/ 2>/dev/null | head -1 || echo 'Ninguno')"
    echo ""
}

# Función para iniciar servidor
start_server() {
    if screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "${YELLOW}⚠️  El servidor ya está ejecutándose${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🚀 Iniciando servidor profesional...${NC}"
    log "Iniciando servidor"
    
    # Verificar Java 17
    export JAVA_HOME=$JAVA_HOME
    export PATH=$JAVA_HOME/bin:$PATH
    
    # Iniciar en screen
    screen -dmS "$SCREEN_NAME" bash -c "
        cd '$SERVER_DIR'
        echo '🎮 Servidor iniciando...'
        echo '⏰ $(date)'
        echo '🔧 Java 17 - Optimizado para producción'
        echo '📊 Configuración: 6GB RAM, G1GC optimizado'
        echo '================================'
        $JAVA_HOME/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.3.0/unix_args.txt nogui
        echo '🛑 Servidor detenido - $(date)' | tee -a '$LOG_FILE'
    "
    
    sleep 3
    
    if screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "${GREEN}✅ Servidor iniciado correctamente${NC}"
        echo -e "${CYAN}💡 Usa 'screen -r $SCREEN_NAME' para ver la consola${NC}"
        echo -e "${CYAN}💡 Usa Ctrl+A, D para salir sin cerrar el servidor${NC}"
    else
        echo -e "${RED}❌ Error al iniciar el servidor${NC}"
        return 1
    fi
}

# Función para detener servidor
stop_server() {
    if ! screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "${YELLOW}⚠️  El servidor no está ejecutándose${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}🛑 Deteniendo servidor...${NC}"
    log "Deteniendo servidor"
    
    # Avisar a jugadores
    screen -S "$SCREEN_NAME" -X stuff "say El servidor se reiniciará en 30 segundos...$(printf '\r')"
    sleep 10
    screen -S "$SCREEN_NAME" -X stuff "say Reinicio en 20 segundos...$(printf '\r')"
    sleep 10
    screen -S "$SCREEN_NAME" -X stuff "say Reinicio en 10 segundos...$(printf '\r')"
    sleep 5
    screen -S "$SCREEN_NAME" -X stuff "say Reinicio en 5 segundos...$(printf '\r')"
    sleep 5
    
    # Detener servidor
    screen -S "$SCREEN_NAME" -X stuff "stop$(printf '\r')"
    
    # Esperar a que se cierre
    for i in {1..30}; do
        if ! screen -list | grep -q "$SCREEN_NAME"; then
            echo -e "${GREEN}✅ Servidor detenido correctamente${NC}"
            return 0
        fi
        sleep 1
    done
    
    # Forzar cierre si es necesario
    echo -e "${RED}⚠️  Forzando cierre del servidor...${NC}"
    screen -S "$SCREEN_NAME" -X quit
    echo -e "${GREEN}✅ Servidor detenido${NC}"
}

# Función de backup
backup_world() {
    echo -e "${BLUE}💾 Creando backup del mundo...${NC}"
    log "Iniciando backup"
    
    if [ ! -d "$WORLD_DIR" ]; then
        echo -e "${RED}❌ No se encontró el mundo${NC}"
        return 1
    fi
    
    BACKUP_NAME="world_backup_$(date +%Y%m%d_%H%M%S)"
    BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME.tar.gz"
    
    # Avisar si el servidor está ejecutándose
    if screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "${YELLOW}⚠️  Creando backup con servidor en ejecución...${NC}"
        screen -S "$SCREEN_NAME" -X stuff "save-all$(printf '\r')"
        screen -S "$SCREEN_NAME" -X stuff "save-off$(printf '\r')"
        sleep 5
    fi
    
    # Crear backup
    tar -czf "$BACKUP_PATH" -C "$SERVER_DIR" world/
    
    # Reactivar saves si el servidor está ejecutándose
    if screen -list | grep -q "$SCREEN_NAME"; then
        screen -S "$SCREEN_NAME" -X stuff "save-on$(printf '\r')"
    fi
    
    if [ -f "$BACKUP_PATH" ]; then
        SIZE=$(du -h "$BACKUP_PATH" | cut -f1)
        echo -e "${GREEN}✅ Backup creado: $BACKUP_NAME ($SIZE)${NC}"
        log "Backup creado: $BACKUP_NAME"
        
        # Limpiar backups antiguos (mantener solo los últimos 10)
        cd "$BACKUP_DIR"
        ls -t *.tar.gz 2>/dev/null | tail -n +11 | xargs rm -f
        echo -e "${CYAN}🧹 Backups antiguos limpiados${NC}"
    else
        echo -e "${RED}❌ Error al crear backup${NC}"
        return 1
    fi
}

# Función de restart
restart_server() {
    echo -e "${YELLOW}🔄 Reiniciando servidor...${NC}"
    log "Reiniciando servidor"
    
    stop_server
    sleep 5
    start_server
}

# Función de monitoreo
monitor_server() {
    echo -e "${BLUE}📊 Monitor del servidor (Ctrl+C para salir)${NC}"
    echo "================================"
    
    while true; do
        clear
        show_banner
        show_status
        
        if screen -list | grep -q "$SCREEN_NAME"; then
            echo -e "${GREEN}🔄 Actualizando cada 5 segundos...${NC}"
            echo ""
            echo -e "${CYAN}Últimas líneas del log:${NC}"
            tail -n 5 logs/latest.log 2>/dev/null || echo "No hay logs disponibles"
        else
            echo -e "${RED}❌ Servidor detenido${NC}"
        fi
        
        sleep 5
    done
}

# Función para ver logs en tiempo real
view_logs() {
    if [ -f "logs/latest.log" ]; then
        echo -e "${BLUE}📄 Logs en tiempo real (Ctrl+C para salir)${NC}"
        tail -f logs/latest.log
    else
        echo -e "${RED}❌ No se encontraron logs${NC}"
    fi
}

# Función para conectar a consola
connect_console() {
    if ! screen -list | grep -q "$SCREEN_NAME"; then
        echo -e "${RED}❌ El servidor no está ejecutándose${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🖥️  Conectando a la consola del servidor...${NC}"
    echo -e "${CYAN}💡 Usa Ctrl+A, D para salir sin cerrar el servidor${NC}"
    sleep 2
    screen -r "$SCREEN_NAME"
}

# Función para limpiar archivos temporales
cleanup() {
    echo -e "${BLUE}🧹 Limpiando archivos temporales...${NC}"
    
    # Limpiar logs antiguos
    find logs/ -name "*.log.gz" -mtime +7 -delete 2>/dev/null
    
    # Limpiar archivos temporales
    rm -f hs_err_pid*.log 2>/dev/null
    rm -f replay_pid*.log 2>/dev/null
    
    echo -e "${GREEN}✅ Limpieza completada${NC}"
}

# Menu principal
show_menu() {
    clear
    show_banner
    show_status
    
    echo -e "${CYAN}🎛️  OPCIONES DISPONIBLES:${NC}"
    echo "================================"
    echo -e "${GREEN}1)${NC} 🚀 Iniciar servidor"
    echo -e "${RED}2)${NC} 🛑 Detener servidor" 
    echo -e "${YELLOW}3)${NC} 🔄 Reiniciar servidor"
    echo -e "${BLUE}4)${NC} 💾 Crear backup"
    echo -e "${PURPLE}5)${NC} 🖥️  Conectar a consola"
    echo -e "${CYAN}6)${NC} 📄 Ver logs en tiempo real"
    echo -e "${BLUE}7)${NC} 📊 Monitor continuo"
    echo -e "${YELLOW}8)${NC} 🧹 Limpiar archivos temporales"
    echo -e "${GREEN}9)${NC} ℹ️  Información del sistema"
    echo -e "${RED}0)${NC} 🚪 Salir"
    echo ""
    echo -n "Selecciona una opción (0-9): "
}

# Función de información del sistema
system_info() {
    echo -e "${BLUE}💻 Información del Sistema${NC}"
    echo "================================"
    echo "Servidor: $(hostname)"
    echo "OS: $(uname -s) $(uname -r)"
    echo "Java: $(java -version 2>&1 | head -1)"
    echo "RAM Total: $(free -h | awk '/^Mem:/{print $2}')"
    echo "RAM Libre: $(free -h | awk '/^Mem:/{print $7}')"
    echo "Disco libre: $(df -h . | awk 'NR==2{print $4}')"
    echo "CPU: $(nproc) cores"
    echo ""
    echo -e "${GREEN}Forge: 1.20.1-47.3.0${NC}"
    echo -e "${GREEN}Mods instalados: $(ls mods/*.jar 2>/dev/null | wc -l)${NC}"
    echo ""
}

# Función principal
main() {
    # Verificar si estamos en el directorio correcto
    if [ ! -f "start_server.sh" ]; then
        echo -e "${RED}❌ Error: Ejecuta este script desde el directorio del servidor${NC}"
        exit 1
    fi
    
    check_dependencies
    
    # Si se pasan argumentos, ejecutar directamente
    case "$1" in
        "start")
            start_server
            exit $?
            ;;
        "stop")
            stop_server
            exit $?
            ;;
        "restart")
            restart_server
            exit $?
            ;;
        "backup")
            backup_world
            exit $?
            ;;
        "status")
            show_status
            exit 0
            ;;
        "console")
            connect_console
            exit $?
            ;;
        *)
            ;;
    esac
    
    # Menu interactivo
    while true; do
        show_menu
        read -r choice
        echo ""
        
        case $choice in
            1)
                start_server
                read -p "Presiona Enter para continuar..."
                ;;
            2)
                stop_server
                read -p "Presiona Enter para continuar..."
                ;;
            3)
                restart_server
                read -p "Presiona Enter para continuar..."
                ;;
            4)
                backup_world
                read -p "Presiona Enter para continuar..."
                ;;
            5)
                connect_console
                ;;
            6)
                view_logs
                ;;
            7)
                monitor_server
                ;;
            8)
                cleanup
                read -p "Presiona Enter para continuar..."
                ;;
            9)
                system_info
                read -p "Presiona Enter para continuar..."
                ;;
            0)
                echo -e "${GREEN}👋 ¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida${NC}"
                sleep 1
                ;;
        esac
        
        clear
    done
}

# Ejecutar función principal
main "$@"
