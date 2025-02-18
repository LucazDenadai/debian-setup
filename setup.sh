#!/bin/bash

# Atualizar a lista de pacotes
sudo apt update

# Adicionar repositórios ao sources.list
sudo tee /etc/apt/sources.list > /dev/null <<EOL
deb http://deb.debian.org/debian bookworm main non-free-firmware
deb-src http://deb.debian.org/debian bookworm main non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware

deb http://deb.debian.org/debian bookworm contrib non-free
deb-src http://deb.debian.org/debian bookworm contrib non-free
EOL

sudo apt update && sudo apt upgrade -y

# Criar um diretório para armazenar os downloads
DOWNLOADS_DIR="$HOME/Downloads/instalados"
mkdir -p "$DOWNLOADS_DIR"

# Instalar o Timeshift e fazer um backup inicial
sudo apt install timeshift -y
sudo timeshift --create --comments "Backup inicial após instalação"

# Instalar drivers da NVIDIA e utilitários de desempenho
sudo dpkg --add-architecture i386
sudo apt update && sudo apt upgrade -y
sudo apt install -y firmware-misc-nonfree intel-microcode linux-headers-amd64 \
  nvidia-driver nvidia-settings libvulkan-dev nvidia-vulkan-icd vulkan-tools vulkan-validationlayers \
  fizmo-sdl2 libsdl2-2.0-0 libsdl2-dev libsdl2-gfx-1.0-0 libsdl2-gfx-dev libsdl2-image-2.0-0 \
  libsdl2-mixer-2.0-0 libsdl2-net-2.0-0

# Instalar pacotes essenciais para programação
sudo apt install -y python3 python3-pip default-jdk nodejs npm git

# Instalar Angular CLI e Yarn globalmente
sudo npm install -g @angular/cli yarn

# Instalar Docker
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Instalar Kubernetes (kubectl)
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update && sudo apt install -y kubectl

# Instalar Visual Studio Code
wget -qO "$DOWNLOADS_DIR/packages.microsoft.gpg" https://packages.microsoft.com/keys/microsoft.asc
gpg --dearmor < "$DOWNLOADS_DIR/packages.microsoft.gpg" > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code

# Criar atalho para Visual Studio Code
mkdir -p ~/.local/share/applications/
cat <<EOL > ~/.local/share/applications/code.desktop
[Desktop Entry]
Name=Visual Studio Code
Comment=Editor de código-fonte
Exec=/usr/bin/code
Icon=code
Terminal=false
Type=Application
Categories=Development;IDE;
EOL

# Instalar JetBrains Toolbox
wget -O "$DOWNLOADS_DIR/jetbrains-toolbox.tar.gz" https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.21.9547.tar.gz
sudo tar -xzf "$DOWNLOADS_DIR/jetbrains-toolbox.tar.gz" -C /opt
/opt/jetbrains-toolbox-*/jetbrains-toolbox &

# Criar atalho para JetBrains Toolbox
cat <<EOL > ~/.local/share/applications/jetbrains-toolbox.desktop
[Desktop Entry]
Name=JetBrains Toolbox
Comment=Gerenciador de IDEs da JetBrains
Exec=/opt/jetbrains-toolbox-*/jetbrains-toolbox
Icon=jetbrains-toolbox
Terminal=false
Type=Application
Categories=Development;IDE;
EOL

# Remover jogos do GNOME
sudo apt remove -y gnome-games

# Instalar ferramentas e extensões do GNOME
sudo apt install -y gnome-tweaks gnome-shell-extensions

# Instalar Flatpak e adicionar repositório Flathub
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar Steam, Discord, Bitwarden, Spotify via Flatpak
for app in com.valvesoftware.Steam com.discordapp.Discord com.bitwarden.desktop com.spotify.Client; do
  sudo flatpak install -y flathub $app
  echo "Aplicativo instalado: $app"
done

# Instalar Brave Browser
wget -qO "$DOWNLOADS_DIR/brave-browser-archive-keyring.gpg" https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo install -o root -g root -m 644 "$DOWNLOADS_DIR/brave-browser-archive-keyring.gpg" /usr/share/keyrings/
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser
sudo update-alternatives --set x-www-browser /usr/bin/brave-browser

# Criar atalho para Brave Browser
cat <<EOL > ~/.local/share/applications/brave-browser.desktop
[Desktop Entry]
Name=Brave Browser
Comment=Navegador web rápido, privado e seguro
Exec=/usr/bin/brave-browser
Icon=brave-browser
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOL

# Instalar Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Atualizar o sistema
sudo apt upgrade -y && sudo apt autoremove -y

# Gerar menu de aplicativos instalados
echo "Programas instalados e disponíveis no menu:"
ls -
::contentReference[oaicite:0]{index=0}
 
