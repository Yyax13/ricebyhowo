#!/bin/bash

# Tokyo Night Rice - Script de Instalação Automática
# Criado por: ricebyhowo
# Baseado no rice do Reddit: https://www.reddit.com/r/unixporn/

set -e

echo "🍚 Iniciando instalação do Rice Tokyo Night..."

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCESSO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Verificar se está no Pop!_OS
print_status "Verificando sistema operacional..."
if ! grep -q "Pop!_OS" /etc/os-release 2>/dev/null; then
    print_warning "Este script foi feito para Pop!_OS, mas pode funcionar em outras distribuições baseadas em Ubuntu/GNOME."
    read -p "Deseja continuar mesmo assim? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Passo 1: Criar estrutura de pastas
print_status "Criando estrutura de pastas..."
mkdir -p ~/.themes ~/.icons ~/.fonts ~/Pictures
print_success "Pastas criadas!"

# Passo 2: Instalar dependências
print_status "Instalando dependências..."
sudo apt update
sudo apt install -y gnome-tweaks chrome-gnome-shell gnome-shell-extension-manager git wget unzip
print_success "Dependências instaladas!"

# Passo 3: Baixar e instalar Tokyo Night GTK Theme
print_status "Baixando Tokyo Night GTK Theme..."
cd /tmp
if [ -d "Tokyo-Night-GTK-Theme" ]; then
    rm -rf Tokyo-Night-GTK-Theme
fi
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
cp -r Tokyo-Night-GTK-Theme/themes/* ~/.themes/
print_success "Tokyo Night GTK Theme instalado!"

# Passo 4: Baixar e instalar Capitaine Cursors
print_status "Baixando e compilando Capitaine Cursors..."
cd /tmp
if [ -d "capitaine-cursors" ]; then
    rm -rf capitaine-cursors
fi
git clone https://github.com/keeferrourke/capitaine-cursors.git
cd capitaine-cursors
./build.sh
cp -r dist/* ~/.icons/
print_success "Capitaine Cursors instalado!"

# Passo 5: Baixar Village Linux Rice (Shell Theme + Wallpaper)
print_status "Baixando Village Linux Rice..."
cd /tmp
if [ -d "Village-Linux-rice" ]; then
    rm -rf Village-Linux-rice
fi
git clone https://github.com/Anant-mishra1729/Village-Linux-rice.git
cp -r Village-Linux-rice/Jasper-Dark-Modified ~/.themes/
cp Village-Linux-rice/Wallpaper.png ~/Pictures/
print_success "Village Linux Rice instalado!"

# Passo 6: Baixar e instalar Logo Menu Extension
print_status "Instalando Logo Menu Extension..."
cd /tmp
if [ -f "logomenu.zip" ]; then
    rm -f logomenu.zip
fi
if [ -d "Logomenu-main" ]; then
    rm -rf Logomenu-main
fi
wget https://github.com/Aryan20/Logomenu/archive/refs/heads/main.zip -O logomenu.zip
unzip -q logomenu.zip
mkdir -p ~/.local/share/gnome-shell/extensions
cp -r Logomenu-main ~/.local/share/gnome-shell/extensions/logomenu@axxapy

# Instalar schemas
sudo cp ~/.local/share/gnome-shell/extensions/logomenu@axxapy/schemas/org.gnome.shell.extensions.logo-menu.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
print_success "Logo Menu Extension instalada!"

# Passo 7: Aplicar configurações do GNOME
print_status "Aplicando configurações do GNOME..."

# Aplicar temas
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Tokyonight-Dark"
gsettings set org.gnome.shell.extensions.user-theme name "Jasper-Dark-Modified"

# Aplicar cursor
gsettings set org.gnome.desktop.interface cursor-theme "capitaine-cursors"

# Definir wallpaper
gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/Pictures/Wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$USER/Pictures/Wallpaper.png"

# Ativar modo escuro
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Habilitar extensões
EXTENSIONS=$(gsettings get org.gnome.shell enabled-extensions)
if [[ $EXTENSIONS != *"user-theme@gnome-shell-extensions.gcampax.github.com"* ]]; then
    gsettings set org.gnome.shell enabled-extensions "$(gsettings get org.gnome.shell enabled-extensions | sed "s/]$/, 'user-theme@gnome-shell-extensions.gcampax.github.com']/")"
fi

if [[ $EXTENSIONS != *"logomenu@axxapy"* ]]; then
    gsettings set org.gnome.shell enabled-extensions "$(gsettings get org.gnome.shell enabled-extensions | sed "s/]$/, 'logomenu@axxapy']/")"
fi

print_success "Configurações aplicadas!"

# Limpeza
print_status "Limpando arquivos temporários..."
cd /tmp
rm -rf Tokyo-Night-GTK-Theme capitaine-cursors Village-Linux-rice Logomenu-main logomenu.zip
print_success "Limpeza concluída!"

echo
echo "🎉 Instalação do Rice Tokyo Night concluída com sucesso!"
echo
print_warning "Para finalizar:"
echo "1. Reinicie o GNOME Shell: Pressione Alt + F2, digite 'r' e pressione Enter"
echo "2. (Opcional) Instale 'Top Bar Organizer' manualmente em https://extensions.gnome.org"
echo "3. Configure o Logo Menu para mostrar o logo do Pop!_OS nas configurações de extensões"
echo
echo "Aproveite seu novo rice! 🍚✨"
