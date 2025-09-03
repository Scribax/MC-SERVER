#!/bin/bash

# ===================================================================
# SCRIPT DE DEPLOYMENT PROFESIONAL PARA VPS
# Servidor Minecraft Forge 1.20.1
# ===================================================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
show_banner() {
    echo -e "${CYAN}=================================================================${NC}"
    echo -e "${GREEN}    🚀 DEPLOYMENT PROFESIONAL A VPS - MINECRAFT FORGE 1.20.1    ${NC}"
    echo -e "${CYAN}=================================================================${NC}"
    echo ""
}

# Configuración (edita estos valores)
VPS_IP=""
VPS_USER=""
VPS_SSH_KEY=""
VPS_PORT="22"
REMOTE_DIR="/opt/minecraft"

# Función de configuración
configure_vps() {
    echo -e "${BLUE}⚙️  Configuración del VPS${NC}"
    echo "================================"
    
    if [ -z "$VPS_IP" ]; then
        read -p "🌐 IP del VPS: " VPS_IP
    fi
    
    if [ -z "$VPS_USER" ]; then
        read -p "👤 Usuario del VPS (default: root): " VPS_USER
        VPS_USER=${VPS_USER:-root}
    fi
    
    read -p "🔑 Ruta a la clave SSH (opcional): " VPS_SSH_KEY
    read -p "🚪 Puerto SSH (default: 22): " VPS_PORT_INPUT
    VPS_PORT=${VPS_PORT_INPUT:-22}
    
    read -p "📁 Directorio remoto (default: /opt/minecraft): " REMOTE_DIR_INPUT
    REMOTE_DIR=${REMOTE_DIR_INPUT:-/opt/minecraft}
    
    echo ""
    echo -e "${GREEN}✅ Configuración guardada${NC}"
    echo -e "${CYAN}IP: $VPS_IP${NC}"
    echo -e "${CYAN}Usuario: $VPS_USER${NC}"
    echo -e "${CYAN}Puerto: $VPS_PORT${NC}"
    echo -e "${CYAN}Directorio: $REMOTE_DIR${NC}"
    echo ""
}

# Función SSH
ssh_exec() {
    local cmd="$1"
    if [ -n "$VPS_SSH_KEY" ]; then
        ssh -i "$VPS_SSH_KEY" -p "$VPS_PORT" "$VPS_USER@$VPS_IP" "$cmd"
    else
        ssh -p "$VPS_PORT" "$VPS_USER@$VPS_IP" "$cmd"
    fi
}

# Función SCP
scp_upload() {
    local source="$1"
    local dest="$2"
    if [ -n "$VPS_SSH_KEY" ]; then
        scp -i "$VPS_SSH_KEY" -P "$VPS_PORT" -r "$source" "$VPS_USER@$VPS_IP:$dest"
    else
        scp -P "$VPS_PORT" -r "$source" "$VPS_USER@$VPS_IP:$dest"
    fi
}

# Preparar servidor localmente
prepare_server() {
    echo -e "${BLUE}📦 Preparando servidor para deployment...${NC}"
    
    # Crear backup antes de deployment
    if [ -d "world" ]; then
        echo -e "${YELLOW}💾 Creando backup pre-deployment...${NC}"
        mkdir -p backups
        tar -czf "backups/pre_deployment_$(date +%Y%m%d_%H%M%S).tar.gz" world/
        echo -e "${GREEN}✅ Backup creado${NC}"
    fi
    
    # Crear archivo de deployment
    cat > deployment_info.txt << EOF
# Información de Deployment
Fecha: $(date)
Versión: Minecraft Forge 1.20.1-47.3.0
Mods: $(ls mods/*.jar 2>/dev/null | wc -l)
Tamaño total: $(du -sh . | cut -f1)
Java requerido: OpenJDK 17

# Archivos incluidos:
$(find . -name "*.jar" -o -name "*.properties" -o -name "*.sh" -o -name "*.md" | sort)
EOF
    
    echo -e "${GREEN}✅ Servidor preparado para deployment${NC}"
}

# Instalar dependencias en VPS
install_vps_dependencies() {
    echo -e "${BLUE}🔧 Instalando dependencias en VPS...${NC}"
    
    ssh_exec "
        # Actualizar sistema
        if command -v apt &> /dev/null; then
            apt update && apt upgrade -y
            apt install -y openjdk-17-jdk screen htop curl wget unzip
        elif command -v yum &> /dev/null; then
            yum update -y
            yum install -y java-17-openjdk screen htop curl wget unzip
        elif command -v pacman &> /dev/null; then
            pacman -Syu --noconfirm
            pacman -S --noconfirm jdk17-openjdk screen htop curl wget unzip
        else
            echo 'Sistema no reconocido. Instala manualmente: Java 17, screen, htop'
            exit 1
        fi
        
        # Verificar Java
        java -version
        
        # Crear usuario minecraft si no existe
        if ! id minecraft &>/dev/null; then
            useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
            echo '✅ Usuario minecraft creado'
        fi
        
        # Crear directorio
        mkdir -p $REMOTE_DIR
        chown minecraft:minecraft $REMOTE_DIR
        
        echo '✅ Dependencias instaladas'
    "
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Dependencias instaladas correctamente${NC}"
    else
        echo -e "${RED}❌ Error instalando dependencias${NC}"
        return 1
    fi
}

# Configurar firewall en VPS
configure_vps_firewall() {
    echo -e "${BLUE}🔥 Configurando firewall en VPS...${NC}"
    
    ssh_exec "
        # UFW (Ubuntu/Debian)
        if command -v ufw &> /dev/null; then
            ufw --force enable
            ufw allow 25565/tcp
            ufw allow OpenSSH
            ufw reload
            echo '✅ UFW configurado'
        # Firewalld (CentOS/RHEL)
        elif command -v firewall-cmd &> /dev/null; then
            systemctl enable firewalld
            systemctl start firewalld
            firewall-cmd --permanent --add-port=25565/tcp
            firewall-cmd --permanent --add-service=ssh
            firewall-cmd --reload
            echo '✅ Firewalld configurado'
        # iptables (genérico)
        else
            iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
            iptables -A INPUT -p tcp --dport 22 -j ACCEPT
            iptables-save > /etc/iptables/rules.v4 2>/dev/null || true
            echo '✅ iptables configurado'
        fi
    "
    
    echo -e "${GREEN}✅ Firewall configurado${NC}"
}

# Subir archivos al VPS
upload_server() {
    echo -e "${BLUE}📤 Subiendo servidor al VPS...${NC}"
    
    # Crear archivo comprimido
    echo -e "${YELLOW}📦 Comprimiendo servidor...${NC}"
    tar -czf minecraft_server_$(date +%Y%m%d_%H%M%S).tar.gz \
        --exclude='*.log' \
        --exclude='logs/*' \
        --exclude='crash-reports/*' \
        --exclude='backups/*' \
        --exclude='.git*' \
        .
    
    # Subir archivo
    echo -e "${YELLOW}📤 Subiendo archivo...${NC}"
    scp_upload "minecraft_server_*.tar.gz" "/tmp/"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Archivo subido correctamente${NC}"
        
        # Extraer en VPS
        echo -e "${YELLOW}📂 Extrayendo en VPS...${NC}"
        ssh_exec "
            cd $REMOTE_DIR
            tar -xzf /tmp/minecraft_server_*.tar.gz
            chown -R minecraft:minecraft $REMOTE_DIR
            chmod +x *.sh
            rm /tmp/minecraft_server_*.tar.gz
            echo '✅ Servidor extraído'
        "
        
        # Limpiar archivo local
        rm minecraft_server_*.tar.gz
        
        echo -e "${GREEN}✅ Servidor desplegado correctamente${NC}"
    else
        echo -e "${RED}❌ Error subiendo archivo${NC}"
        return 1
    fi
}

# Crear servicio systemd
create_systemd_service() {
    echo -e "${BLUE}⚙️  Creando servicio systemd...${NC}"
    
    ssh_exec "
        cat > /etc/systemd/system/minecraft.service << 'EOF'
[Unit]
Description=Minecraft Forge Server 1.20.1
After=network.target

[Service]
Type=forking
User=minecraft
WorkingDirectory=$REMOTE_DIR
ExecStart=/usr/bin/screen -dmS minecraft_server $REMOTE_DIR/start_server.sh nogui
ExecStop=/usr/bin/screen -S minecraft_server -X stuff 'stop\n'
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

        systemctl daemon-reload
        systemctl enable minecraft
        echo '✅ Servicio systemd creado'
    "
    
    echo -e "${GREEN}✅ Servicio systemd configurado${NC}"
}

# Verificar deployment
verify_deployment() {
    echo -e "${BLUE}🔍 Verificando deployment...${NC}"
    
    ssh_exec "
        cd $REMOTE_DIR
        echo '=== Verificación de Deployment ==='
        echo 'Directorio actual:' \$(pwd)
        echo 'Usuario actual:' \$(whoami)
        echo 'Java version:'
        java -version 2>&1 | head -1
        echo 'Archivos principales:'
        ls -la *.sh server.properties eula.txt 2>/dev/null
        echo 'Mods instalados:' \$(ls mods/*.jar 2>/dev/null | wc -l)
        echo 'Espacio en disco:'
        df -h .
        echo '================================='
    "
    
    echo ""
    echo -e "${GREEN}✅ Verificación completada${NC}"
}

# Test de conexión
test_connection() {
    echo -e "${BLUE}🧪 Probando conexión al VPS...${NC}"
    
    if ssh_exec "echo 'Conexión exitosa'"; then
        echo -e "${GREEN}✅ Conexión SSH funcionando${NC}"
        return 0
    else
        echo -e "${RED}❌ Error de conexión SSH${NC}"
        return 1
    fi
}

# Iniciar servidor en VPS
start_remote_server() {
    echo -e "${BLUE}🚀 Iniciando servidor en VPS...${NC}"
    
    ssh_exec "
        cd $REMOTE_DIR
        sudo -u minecraft ./server_manager.sh start
    "
    
    echo -e "${GREEN}✅ Comando de inicio enviado${NC}"
    echo -e "${CYAN}💡 Conéctate al VPS y usa './server_manager.sh status' para verificar${NC}"
}

# Deployment completo
full_deployment() {
    echo -e "${YELLOW}🚀 Iniciando deployment completo...${NC}"
    echo ""
    
    configure_vps
    
    if ! test_connection; then
        echo -e "${RED}❌ No se puede conectar al VPS${NC}"
        exit 1
    fi
    
    prepare_server
    install_vps_dependencies
    configure_vps_firewall
    upload_server
    create_systemd_service
    verify_deployment
    
    echo ""
    echo -e "${GREEN}🎉 ¡DEPLOYMENT COMPLETADO!${NC}"
    echo ""
    echo -e "${CYAN}📋 PRÓXIMOS PASOS:${NC}"
    echo "1. Conéctate al VPS: ssh $VPS_USER@$VPS_IP"
    echo "2. Ve al directorio: cd $REMOTE_DIR"
    echo "3. Inicia el servidor: sudo -u minecraft ./server_manager.sh start"
    echo "4. Verifica el estado: sudo -u minecraft ./server_manager.sh status"
    echo ""
    echo -e "${YELLOW}🌐 Tu servidor estará disponible en: $VPS_IP:25565${NC}"
    echo ""
    
    read -p "¿Quieres iniciar el servidor ahora? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        start_remote_server
    fi
}

# Solo subir archivos
quick_upload() {
    echo -e "${YELLOW}📤 Subida rápida de archivos...${NC}"
    
    if [ -z "$VPS_IP" ]; then
        configure_vps
    fi
    
    if ! test_connection; then
        exit 1
    fi
    
    prepare_server
    upload_server
    
    echo -e "${GREEN}✅ Archivos subidos correctamente${NC}"
}

# Menu principal
show_menu() {
    show_banner
    
    echo -e "${CYAN}🎛️  OPCIONES DE DEPLOYMENT:${NC}"
    echo "================================"
    echo -e "${GREEN}1)${NC} 🚀 Deployment completo (recomendado)"
    echo -e "${BLUE}2)${NC} 📤 Solo subir archivos"
    echo -e "${YELLOW}3)${NC} 🔧 Configurar VPS"
    echo -e "${CYAN}4)${NC} 🧪 Probar conexión"
    echo -e "${PURPLE}5)${NC} 🔍 Verificar servidor remoto"
    echo -e "${GREEN}6)${NC} 🚀 Iniciar servidor remoto"
    echo -e "${RED}0)${NC} 🚪 Salir"
    echo ""
    echo -n -e "${CYAN}Selecciona una opción: ${NC}"
}

# Función principal
main() {
    if [ "$1" == "full" ]; then
        full_deployment
        exit 0
    elif [ "$1" == "upload" ]; then
        quick_upload
        exit 0
    fi
    
    while true; do
        show_menu
        read -r choice
        echo ""
        
        case $choice in
            1)
                full_deployment
                break
                ;;
            2)
                quick_upload
                read -p "Presiona Enter para continuar..."
                ;;
            3)
                configure_vps
                read -p "Presiona Enter para continuar..."
                ;;
            4)
                test_connection
                read -p "Presiona Enter para continuar..."
                ;;
            5)
                verify_deployment
                read -p "Presiona Enter para continuar..."
                ;;
            6)
                start_remote_server
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

# Verificar si estamos en el directorio correcto
if [ ! -f "start_server.sh" ]; then
    echo -e "${RED}❌ Error: Ejecuta este script desde el directorio del servidor${NC}"
    exit 1
fi

main "$@"
