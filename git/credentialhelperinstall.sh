#!/bin/bash

# Script para instalar e configurar o Git Credential Manager no Kali Linux

# Atualiza a lista de pacotes
sudo apt update

# Instala dependências necessárias
sudo apt install -y wget git curl libcurl4 libexpat1 gettext gnupg

# Define a versão desejada do Git Credential Manager
GCM_VERSION="2.4.1"

# Baixa o .deb do Git Credential Manager a partir do GitHub
wget https://github.com/GitCredentialManager/git-credential-manager/releases/download/v${GCM_VERSION}/gcm-linux_amd64.${GCM_VERSION}.deb -O gcm.deb

# Instala o pacote .deb
sudo dpkg -i gcm.deb

# Remove o arquivo .deb após a instalação (opcional)
rm gcm.deb

# Configura o Git para usar o Git Credential Manager
git config --global credential.helper manager

# Confirmação
echo "Git Credential Manager instalado e configurado com sucesso!"
