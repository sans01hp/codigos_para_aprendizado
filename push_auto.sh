#!/bin/bash

# Script para automatizar git push usando variáveis de ambiente
# As variáveis NOME, TOKEN e REPO devem ser definidas no .env:
# export NOME="seu_nome"
# export TOKEN="seu_token_github" 
# export REPO="nome-do-repositorio"

#===========================================================
# Verificando se variáveis de ambiente estão ativas
#===========================================================
if [ -z "$ENV_ON" ]; then
    printf "\u001B[1;33m[AVISO] Variáveis de ambiente não carregadas.\u001B[0m
"
    printf "Renomeie o arquivo \u001B[1m.env.example\u001B[0m para \u001B[1m.env\u001B[0m
"
    printf "Atribua os valores correspondentes ao seu usuario e token do github
"
    printf "execute: \u001B[1msource .env\u001B[0m
"
    exit 1
else
    printf "\u001B[1;92m✅ .env carregado com sucesso: ENV_ON='%s'\u001B[0m
" "$ENV_ON"
fi

# Verifica se a variável NOME está definida
if [ -z "$NOME" ]; then
  echo "🚫 ERRO: Variável de ambiente NOME não definida."
  echo "Defina com: export NOME="seu_nome""
  exit 1
fi

# Verifica se a variável TOKEN está definida
if [ -z "$TOKEN" ]; then
  echo "🚫 ERRO: Variável de ambiente TOKEN não definida."
  echo "Defina com: export TOKEN="seu_token_github""
  exit 1
fi

# Verifica se a variável REPO está definida
if [ -z "$REPO" ]; then
  echo "🚫 ERRO: Variável de ambiente REPO não definida."
  echo "Defina com: export REPO="nome-do-seu-repositorio""
  exit 1
fi

# Configura git user.name e user.email localmente no repositório
git config user.name "$NOME"
git config user.email "${NOME}@users.noreply.github.com"

# Adiciona todos os arquivos
echo "📂 Adicionando arquivos..."
git add .

# Pede a mensagem do commit
read -p "Digite a mensagem do commit: " MENSAGEM

if [ -z "$MENSAGEM" ]; then
  echo "🚫 ERRO: Mensagem de commit não pode ser vazia."
  exit 1
fi

# Faz o commit
echo "✅ Commit: $MENSAGEM"
git commit -m "$MENSAGEM"

# Salva URL original
ORIGINAL_URL=$(git remote get-url origin)

# Configura remote temporário com token (FIX do sed)
echo "🔐 Configurando autenticação com token..."
git remote set-url origin "https://${TOKEN}@github.com/${NOME}/${REPO}.git"

# Faz o push
echo "🚀 Fazendo push para o GitHub..."
if git push origin HEAD; then
    echo "✅ Push concluído com sucesso!"
    
    # Restaura URL original
    git remote set-url origin "$ORIGINAL_URL"
    echo "🔄 Remote original restaurado."
else
    echo "❌ Push falhou. Restaurando remote original..."
    git remote set-url origin "$ORIGINAL_URL"
    exit 1
fi
