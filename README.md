# Como Configurar o Rice "Tokyo Night"

Este guia é para ajudar você a configurar um ambiente de desktop visualmente atraente chamado "Tokyo Night" no Pop!_OS. 

## Requisitos

- **Pop!_OS** como sistema operacional.
- **GNOME** desktop environment.

## Estrutura de Pastas Necessária

Crie as pastas necessárias no diretório home (se ainda não existirem):

```bash
mkdir -p ~/.themes ~/.icons ~/.fonts
```

## Instalação de Dependências

Certifique-se de instalar o **GNOME Tweaks**:

```bash
sudo apt update
sudo apt install gnome-tweaks
```

E instale o conector GNOME para extensões do navegador:

```bash
sudo apt install chrome-gnome-shell
```

## Instalação dos Temas

### 1. **Tokyo Night GTK Theme**
Clone o repositório e mova o tema para `~/.themes`:

```bash
cd /tmp
 git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
cp -r Tokyo-Night-GTK-Theme/themes/* ~/.themes/
```

### 2. **Capitaine Cursors**
Clone o repositório, compile e mova os cursores para `~/.icons`:

```bash
cd /tmp
 git clone https://github.com/keeferrourke/capitaine-cursors.git
cd capitaine-cursors
./build.sh
cp -r dist ~/.icons/
```

### 3. **Village Linux Rice**
Clone o tema de shell e baixe o wallpaper:

```bash
cd /tmp
 git clone https://github.com/Anant-mishra1729/Village-Linux-rice.git
cp -r Village-Linux-rice/Jasper-Dark-Modified ~/.themes/
cp Village-Linux-rice/Wallpaper.png ~/Pictures/
```

## Configuração do GNOME

Para aplicar os temas e cursor:

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Tokyonight-Dark"
gsettings set org.gnome.shell.extensions.user-theme name "Jasper-Dark-Modified"
```

Para aplicar os cursores:

```bash
gsettings set org.gnome.desktop.interface cursor-theme "capitaine-cursors"
```

Para definir o wallpaper:

```bash
gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/Pictures/Wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$USER/Pictures/Wallpaper.png"
```

Ativar o modo escuro:

```bash
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
```

## Instalação de Extensões GNOME

### 1. **Logo Menu**

Baixe e instale a extensão:

```bash
cd /tmp
wget https://github.com/Aryan20/Logomenu/archive/refs/heads/main.zip -O logomenu.zip
unzip logomenu.zip
cp -r Logomenu-main ~/.local/share/gnome-shell/extensions/logomenu@axxapy

sudo cp ~/.local/share/gnome-shell/extensions/logomenu@axxapy/schemas/org.gnome.shell.extensions.logo-menu.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
```

Ative a extensão:

```bash
gsettings set org.gnome.shell enabled-extensions "['ding@rastersoft.com', 'pop-cosmic@system76.com', 'pop-shell@system76.com', 'system76-power@system76.com', 'ubuntu-appindicators@ubuntu.com', 'cosmic-dock@system76.com', 'cosmic-workspaces@system76.com', 'popx11gestures@system76.com', 'alt-tab-scroll-workaround@lucasresck.github.io', 'CoverflowAltTab@palatis.blogspot.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'logomenu@axxapy']"
```

### Nota sobre Top Bar Organizer

Atualmente, a extensão Top Bar Organizer não foi instalada automaticamente. Verifique o site de extensões do GNOME ([extensions.gnome.org](https://extensions.gnome.org)) para instalá-la manualmente.

## Finalizando a configuração

**Reinicie o GNOME Shell** para aplicar todas as configurações:

- Pressione `Alt + F2`, digite `r` e pressione Enter.

Agora você está pronto para aproveitar o seu novo visual "Tokyo Night" no Pop!_OS!

bash:
rode
```bash
cp -r neofetch ~/.nfetch
```