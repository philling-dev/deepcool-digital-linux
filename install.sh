#!/bin/bash

# Deepcool AK500S Digital Linux - Script de Instalação Automatizada
# Suporte: Ubuntu, Debian, Linux Mint
# Versão: 1.0

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Este script não deve ser executado como root!"
        print_warning "Execute: ./install.sh"
        exit 1
    fi
}

check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        print_error "Este script precisa de privilégios sudo."
        print_warning "Configure sudo sem senha ou execute com sudo disponível."
        exit 1
    fi
}

check_supported_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu|debian|linuxmint)
                print_success "Sistema suportado: $PRETTY_NAME"
                ;;
            *)
                print_warning "Sistema não testado: $PRETTY_NAME"
                read -p "Continuar mesmo assim? (y/N): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    exit 1
                fi
                ;;
        esac
    else
        print_error "Não foi possível detectar a distribuição."
        exit 1
    fi
}

install_dependencies() {
    print_status "Instalando dependências..."
    
    sudo apt update
    sudo apt install -y \
        git \
        python3 \
        python3-pip \
        python3-venv \
        libusb-1.0-0-dev \
        libudev-dev \
        curl \
        build-essential
    
    print_success "Dependências instaladas."
}

install_rust() {
    if command -v rustc &> /dev/null; then
        print_success "Rust já está instalado."
        return
    fi
    
    print_status "Instalando Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    print_success "Rust instalado."
}

clone_and_build() {
    print_status "Clonando repositório..."
    
    REPO_DIR="/tmp/deepcool-ak500-digital-linux-install"
    if [ -d "$REPO_DIR" ]; then
        rm -rf "$REPO_DIR"
    fi
    
    git clone https://github.com/shakil89427/deepcool-ak500-digital-linux.git "$REPO_DIR"
    cd "$REPO_DIR"
    
    print_status "Compilando software..."
    source ~/.cargo/env
    cargo build --release
    
    print_success "Compilação concluída."
}

install_binary() {
    print_status "Instalando executável..."
    sudo cp "$REPO_DIR/target/release/deepcool-digital-linux" /usr/sbin/
    sudo chmod +x /usr/sbin/deepcool-digital-linux
    print_success "Executável instalado em /usr/sbin/"
}

create_service() {
    print_status "Criando serviço systemd..."
    
    sudo tee /etc/systemd/system/deepcool-digital.service > /dev/null <<EOF
[Unit]
Description=DeepCool Digital AK500S Temperature Display
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/sbin/deepcool-digital-linux --mode temp --alarm
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    print_success "Serviço criado."
}

setup_udev_rules() {
    print_status "Configurando regras udev para execução sem root..."
    
    sudo tee /etc/udev/rules.d/99-deepcool-digital.rules > /dev/null <<EOF
# Intel RAPL energy usage file
ACTION=="add", SUBSYSTEM=="powercap", KERNEL=="intel-rapl:0", RUN+="/bin/chmod 444 /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# DeepCool HID raw devices
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3633", MODE="0666"
EOF

    sudo udevadm control --reload-rules
    sudo udevadm trigger
    print_success "Regras udev configuradas."
}

detect_device() {
    print_status "Detectando dispositivo Deepcool..."
    
    if sudo /usr/sbin/deepcool-digital-linux --list | grep -q "AK500S-DIGITAL"; then
        print_success "Deepcool AK500S Digital detectado!"
        return 0
    else
        print_error "Dispositivo não detectado. Verifique se está conectado."
        return 1
    fi
}

start_service() {
    print_status "Habilitando e iniciando serviço..."
    
    sudo systemctl enable deepcool-digital
    sudo systemctl start deepcool-digital
    
    sleep 2
    
    if sudo systemctl is-active --quiet deepcool-digital; then
        print_success "Serviço iniciado com sucesso!"
        print_status "Status do serviço:"
        sudo systemctl status deepcool-digital --no-pager -l
    else
        print_error "Falha ao iniciar o serviço."
        print_status "Logs do serviço:"
        sudo journalctl -u deepcool-digital --no-pager -l
        return 1
    fi
}

show_usage() {
    echo
    print_success "=== INSTALAÇÃO CONCLUÍDA ==="
    echo
    echo "Comandos úteis:"
    echo "  • Ver status:      sudo systemctl status deepcool-digital"
    echo "  • Parar serviço:   sudo systemctl stop deepcool-digital"
    echo "  • Iniciar serviço: sudo systemctl start deepcool-digital"
    echo "  • Ver logs:        sudo journalctl -u deepcool-digital -f"
    echo "  • Executar manual: sudo /usr/sbin/deepcool-digital-linux"
    echo
    echo "Opções do software:"
    echo "  --mode temp|usage|auto   (modo de exibição)"
    echo "  --fahrenheit             (usar Fahrenheit)"
    echo "  --alarm                  (habilitar alarme a 85°C)"
    echo "  --list                   (listar dispositivos)"
    echo
    print_success "Seu Deepcool AK500S agora exibe a temperatura no visor!"
}

cleanup() {
    if [ -d "$REPO_DIR" ]; then
        rm -rf "$REPO_DIR"
    fi
}

main() {
    echo
    echo "=== Deepcool AK500S Digital Linux - Instalador ==="
    echo
    
    check_root
    check_sudo
    check_supported_distro
    
    install_dependencies
    install_rust
    clone_and_build
    install_binary
    create_service
    setup_udev_rules
    
    if detect_device; then
        start_service
        show_usage
    else
        print_warning "Conecte o dispositivo e execute: sudo systemctl start deepcool-digital"
    fi
    
    cleanup
    print_success "Instalação finalizada!"
}

# Trap para cleanup em caso de erro
trap cleanup EXIT

main "$@"