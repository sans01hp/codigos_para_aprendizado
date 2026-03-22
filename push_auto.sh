#!/bin/bash

# Script para automatizar git push
# As variáveis NOME e TOKEN no .env:
# export NOME="seu_nome"
# export TOKEN="seu_token_github" 

#===========================================================
# Verificando variáveis
#===========================================================
if [ -z "$ENV_ON" ]; then
    printf "\033[1;33m[AVISO] Variáveis não carregadas.\033[0m\n"
    printf "source .env\n"
    exit 1
fi
printf "\033[1;92m✅ .env OK: %s\033[0m\n" "$ENV_ON"

if [ -z "$NOME" ] || [ -z "$TOKEN" ]; then
  echo "🚫 ERRO: NOME ou TOKEN faltando."
  exit 1
fi

# Config git local
git config user.name "$NOME"
git config user.email "${NOME}@users.noreply.github.com"

# Add + commit
echo "📂 Adicionando..."
git add .

read -p "Mensagem commit: " MENSAGEM
if [ -z "$MENSAGEM" ]; then
  echo "🚫 Mensagem vazia!"
  exit 1
fi

echo "✅ Commit: $MENSAGEM"
git commit -m "$MENSAGEM"

# 🔥 EXTRAIR REPO da URL atual
ORIGINAL_URL=$(git remote get-url origin)
REPO_NAME=$(basename "$ORIGINAL_URL" .git)        # "repo.git" → "repo"
USER_NAME=$(git remote get-url origin | sed -n 's|.*/\([^/]*\)/\([^.]*\)\.git$|\1|p')  # Extrai usuário

echo "🔍 Detectado: $USER_NAME/$REPO_NAME"

# Push temporário
echo "🔐 Config token..."
git remote set-url origin "https://${TOKEN}@github.com/${NOME}/${REPO_NAME}.git"

if git push origin HEAD; then
    echo "✅ Push OK!"
    git remote set-url origin "$ORIGINAL_URL"  # Restaura
    echo "🔄 Original restaurado."
else
    echo "❌ Falhou!"
    git remote set-url origin "$ORIGINAL_URL"
    exit 1
fi
