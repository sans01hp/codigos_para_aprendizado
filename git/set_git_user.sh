#!/bin/bash

###########################################################
# 📌 EXPLICAÇÃO: COMO O Git USA user.name E user.email
#
# O Git precisa de dois dados pra assinar cada commit:
#   - user.name  -> o nome que aparece como autor
#   - user.email -> o e-mail que aparece como autor
#
# Esses dados podem ser configurados em 3 ESCOPOS:
#
# 1️⃣ System  -> --system
#    - Afeta TODOS os usuários e repositórios do sistema
#    - Salvo em: /etc/gitconfig (Linux)
#
#    Exemplo:
#      sudo git config --system user.name "Nome System"
#
# 2️⃣ Global  -> --global
#    - Afeta apenas o seu usuário no computador (todos os seus repositórios)
#    - Salvo em: ~/.gitconfig
#
#    Exemplo:
#      git config --global user.name "Seu Nome Global"
#      git config --global user.email "seu@email.com"
#
# 3️⃣ Local (padrão) -> --local
#    - Afeta apenas o repositório atual
#    - Salvo em: <repo>/.git/config
#
#    Exemplo:
#      git config user.name "Nome Só Neste Repo"
#      git config user.email "outro@email.com"
#
#    Obs: Se você rodar `git config` DENTRO de um repositório
#    sem passar `--global` ou `--system`, é LOCAL por padrão.
#
# 🗂️ Prioridade:
#    Local > Global > System
#
# 🟢 Na prática:
#    - Se LOCAL existir, vale ele.
#    - Se não, usa GLOBAL.
#    - Se não, usa SYSTEM.
#
# -----------------------------------------------------------
# 🔒 SOBRE TOKEN DE ACESSO:
# Para fazer PUSH ou PULL em repositórios privados no GitHub,
# é comum precisar de um Personal Access Token (PAT).
#
# ⚠️ NÃO coloque o token direto no script.
# O jeito mais seguro:
#   - Configure uma variável de ambiente ou use um helper:
#     git config --global credential.helper store
#     git config --global credential.helper cache
#   - Ou use SSH em vez de HTTPS, para não precisar do token toda hora.
#
# O token só é necessário para AUTENTICAR ao servidor remoto.
# Ele NÃO é usado nos commits em si.
###########################################################

# --------------------------------------
# ⚙️ SCRIPT PARA ALTERAR CONFIG LOCAL EM VÁRIOS REPOSITÓRIOS
# --------------------------------------

# Nome e e-mail que serão aplicados LOCALMENTE
USERNAME="Seu Nome"
USEREMAIL="seu@email.com"

# Lista de repositórios (caminhos absolutos)
REPOS=(
  "/caminho/para/projeto1"
  "/caminho/para/projeto2"
  "/caminho/para/projeto3"
)

# --------------------------------------
# LOOP: aplica config local em cada repo
# --------------------------------------

for REPO in "${REPOS[@]}"; do
  if [ -d "$REPO/.git" ]; then
    echo "🔧 Configurando repositório: $REPO"
    git config --file "$REPO/.git/config" user.name "$USERNAME"
    git config --file "$REPO/.git/config" user.email "$USEREMAIL"
    echo "✅ Configuração aplicada!"
  else
    echo "⚠️ Aviso: $REPO não é um repositório Git!"
  fi
done

echo "🎉 Todas as configs locais foram ajustadas com sucesso!"
