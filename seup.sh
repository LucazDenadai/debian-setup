#!/bin/bash

# Atualizar a lista de pacotes
sudo apt update

# Instalar o Timeshift e fazer um backup inicial
sudo apt install timeshift -y
sudo timeshift --create --comments "Backup inicial após instalação"

# Instalar drivers da NVIDIA e utilitários de desempenho
sudo apt install -y nvidia-driver nvidia-settings nvidia-prime mesa-utils
sudo apt install -y libvulkan1 libvulkan1:i386 vulkan-tools vulkan-utils

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
sudo apt update
sudo apt install -y kubectl

# Instalar Visual Studio Code
sudo apt install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Instalar JetBrains Toolbox
wget -O jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.21.9547.tar.gz
sudo tar -xzf jetbrains-toolbox.tar.gz -C /opt
rm jetbrains-toolbox.tar.gz
/opt/jetbrains-toolbox-*/jetbrains-toolbox

# Remover jogos do GNOME
sudo apt remove -y gnome-games

# Instalar ferramentas e extensões do GNOME
sudo apt install -y gnome-tweaks gnome-shell-extensions

# Instalar Flatpak e adicionar repositório Flathub
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar Steam, Discord, Bitwarden, Spotify via Flatpak
sudo flatpak install -y flathub com.valvesoftware.Steam
sudo flatpak install -y flathub com.discordapp.Discord
sudo flatpak install -y flathub com.bitwarden.desktop
sudo flatpak install -y flathub com.spotify.Client

# Instalar Brave Browser
sudo apt install -y curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# Definir Brave como navegador padrão
sudo update-alternatives --set x-www-browser /usr/bin/brave-browser

# Instalar Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Atualizar o sistema
sudo apt upgrade -y
sudo apt autoremove -y

echo "Instalação concluída!"