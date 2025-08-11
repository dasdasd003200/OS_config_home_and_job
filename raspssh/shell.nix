# ~/raspssh/shell.nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.sshfs
    pkgs.neovim
    pkgs.openssh
    pkgs.rsync
    pkgs.fuse
    pkgs.git
  ];
  
  shellHook = ''
    # ============================================
    # 🍓 RASPBERRY PI DEVELOPMENT ENVIRONMENT
    # ============================================
    
    # Colores para output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    NC='\033[0m'
    
    # Configuración
    export RASP_USER="dasdasd"
    export RASP_IP="192.168.1.200"
    export RASP_MOUNT_POINT="$PWD/raspberry"
    export XDG_CONFIG_HOME="$HOME/.config"
    
    echo -e "🍓 ''${GREEN}Raspberry Pi Development Environment''${NC}"
    echo -e "📍 Target: ''${CYAN}$RASP_USER@$RASP_IP''${NC}"
    echo -e "📁 Mount: ''${YELLOW}$RASP_MOUNT_POINT''${NC}"
    echo ""
    
    # Crear directorio de montaje
    mkdir -p "$RASP_MOUNT_POINT"
    
    # Función para verificar si está montado
    is_mounted() {
      mountpoint -q "$RASP_MOUNT_POINT" 2>/dev/null
    }
    
    # Auto-montar Raspberry Pi al entrar
    echo -e "🔌 ''${BLUE}Auto-montando Raspberry Pi...''${NC}"
    
    if is_mounted; then
      echo -e "⚠️  ''${YELLOW}Ya está montado''${NC}"
    else
      sshfs "$RASP_USER@$RASP_IP:/" "$RASP_MOUNT_POINT" \
        -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 \
        -o follow_symlinks,cache=yes,compression=yes \
        -o StrictHostKeyChecking=no 2>/dev/null
      
      if [ $? -eq 0 ]; then
        echo -e "✅ ''${GREEN}Raspberry Pi montado exitosamente''${NC}"
      else
        echo -e "❌ ''${RED}Error al montar. Verificar conexión SSH''${NC}"
        echo -e "💡 ''${YELLOW}Prueba manualmente: ssh $RASP_USER@$RASP_IP''${NC}"
      fi
    fi
    
    # Función para desmontar al salir
    cleanup() {
      echo ""
      echo -e "🔌 ''${BLUE}Desmontando Raspberry Pi...''${NC}"
      if is_mounted; then
        fusermount -u "$RASP_MOUNT_POINT" 2>/dev/null || umount "$RASP_MOUNT_POINT"
        if [ $? -eq 0 ]; then
          echo -e "✅ ''${GREEN}Desmontado exitosamente''${NC}"
        else
          echo -e "⚠️  ''${YELLOW}Puede requerir desmontaje manual''${NC}"
        fi
      fi
      echo -e "👋 ''${PURPLE}Hasta luego!''${NC}"
    }
    
    # Configurar trap para cleanup al salir
    trap cleanup EXIT INT TERM
    
    # Cambiar al directorio del Raspberry automáticamente
    if is_mounted; then
      cd "$RASP_MOUNT_POINT/home/$RASP_USER"
      echo -e "📂 ''${GREEN}Cambiado a directorio del usuario en Raspberry''${NC}"
      echo -e "🎯 ''${CYAN}Ubicación actual: $(pwd)''${NC}"
    fi
    
    # Alias útiles
    alias ll='ls -la'
    alias la='ls -la'
    alias l='ls -l'
    alias ..='cd ..'
    alias ...='cd ../..'
    
    # Funciones específicas para Raspberry
    rasp_home() {
      cd "$RASP_MOUNT_POINT/home/$RASP_USER"
      echo -e "🏠 ''${GREEN}En directorio home del Raspberry''${NC}"
    }
    
    rasp_root() {
      cd "$RASP_MOUNT_POINT"
      echo -e "🌳 ''${GREEN}En directorio raíz del Raspberry''${NC}"
    }
    
    rasp_logs() {
      cd "$RASP_MOUNT_POINT/var/log"
      echo -e "📋 ''${GREEN}En directorio de logs''${NC}"
    }
    
    rasp_etc() {
      cd "$RASP_MOUNT_POINT/etc"
      echo -e "⚙️  ''${GREEN}En directorio de configuración''${NC}"
    }
    
    # Función para comandos SSH rápidos
    rasp_cmd() {
      if [ -z "$1" ]; then
        echo -e "💡 ''${YELLOW}Uso: rasp_cmd comando''${NC}"
        echo -e "📝 ''${CYAN}Ejemplo: rasp_cmd docker ps''${NC}"
        return 1
      fi
      
      echo -e "🚀 ''${BLUE}Ejecutando: $1''${NC}"
      ssh "$RASP_USER@$RASP_IP" "$1"
    }
    
    # Función para SSH interactivo
    rasp_ssh() {
      echo -e "🔗 ''${BLUE}Conectando SSH al Raspberry...''${NC}"
      ssh "$RASP_USER@$RASP_IP"
    }
    
    # Exportar funciones
    export -f rasp_home rasp_root rasp_logs rasp_etc rasp_cmd rasp_ssh
    
    # Información del entorno
    echo ""
    echo -e "🛠️  ''${PURPLE}Comandos disponibles:''${NC}"
    echo -e "   ''${CYAN}nvim''${NC}       - Tu LazyVim completo con archivos del Raspberry"
    echo -e "   ''${CYAN}rasp_home''${NC}  - Ir a /home/dasdasd/"
    echo -e "   ''${CYAN}rasp_root''${NC}  - Ir a directorio raíz /"
    echo -e "   ''${CYAN}rasp_logs''${NC}  - Ir a /var/log/"
    echo -e "   ''${CYAN}rasp_etc''${NC}   - Ir a /etc/"
    echo -e "   ''${CYAN}rasp_ssh''${NC}   - SSH interactivo"
    echo -e "   ''${CYAN}rasp_cmd''${NC}   - Ejecutar comando remoto"
    echo ""
    echo -e "🎯 ''${GREEN}Todo listo! Usa nvim . para abrir LazyVim en el directorio actual''${NC}"
    echo -e "📝 ''${YELLOW}Ejemplo: nvim docker-compose.yml''${NC}"
    echo ""
  '';
}
