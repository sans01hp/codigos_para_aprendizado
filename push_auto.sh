#!/bin/bash

# Script para automatizar git push usando variáveis de ambiente
# As variáveis NOME e TOKEN devem ser definidas fora do script, assim:
# export NOME="seu_nome"
# export TOKEN="seu_token_github"
# usar o export para definir as variáveis ou então usar o comando:
# git remote set-url origin https://<TOKEN>@github.com/<USUARIO>/<REPOSITORIO>.git

#===========================================================
# Verificando se uma variavéis de ambiente estão ativas
#===========================================================
if [ -z "$ENV_ON" ]; then
    printf "\033[1;33m[AVISO] Variáveis de ambiente não carregadas.\033[0m\n"
    printf "Renomeie o arquivo \033[1m.env.example\033[0m para \033[1m.env\033[0m\n"
    printf "Atribua os valores correspondentes ao seu  usuario e token do github\nexecute: \033[1msource .env\033[0m\n"
    exit 1
  else
    printf "\033[1;92m�� .env carregado com sucesso: ENV_ON='%s'\033[0m\n" "$ENV_ON"
fi

# Verifica se a variável NOME está definida
if [ -z "$NOME" ]; then
  echo "🚫 ERRO: Variável de ambiente NOME não definida."
  echo "Defina com: export NOME=\"seu_nome\""
  exit 1
fi

# Verifica se a variável TOKEN está definida
if [ -z "$TOKEN" ]; then
  echo "🚫 ERRO: Variável de ambiente TOKEN não definida."
  echo "Defina com: export TOKEN=\"seu_token_github\""
  exit 1
fi

# Configura git user.name e user.email localmente no repositório, para evitar erro de commit
git config user.name "$NOME"
# Aqui você pode ajustar o email, por exemplo:
git config user.email "$NOME@users.noreply.github.com"

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
git commit -m "$MENSAGEM"

# Obtém a URL remota atual
REMOTE_URL=$(git remote get-url origin)

# Substitui a URL para colocar o token no HTTPS (para autenticação)
REMOTE_URL_COM_TOKEN=$(echo "$REMOTE_URL" | sed -E "s#(https://)(.*)#\1$TOKEN@\2#")

# Faz o push usando a URL com token embutido
echo "🚀 Fazendo push para o GitHub..."
git push "$REMOTE_URL_COM_TOKEN" HEAD

echo "✅ Push concluído com sucesso!"
