#!/bin/zsh
# Script exemplo feito para o Zsh com boas práticas

# ----------------------------------------
# Cores ANSI (exemplo de estilo)
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# ----------------------------------------
# Exemplo: leitura de uma variável de entrada
read "url?Digite uma URL: "

# ----------------------------------------
# Verificação se a string não está vazia
if [[ -z "$url" ]]; then
    printf "${RED}[ERRO]${RESET} A URL está vazia.\n"
    exit 1
fi

# ----------------------------------------
# Regex: Verifica se começa com "https"
if [[ "$url" =~ ^https ]]; then
    printf "${GREEN}✅ URL segura detectada:${RESET} $url\n"
else
    printf "${YELLOW}⚠️ URL não segura:${RESET} $url\n"
fi

# ----------------------------------------
# Substituição: Remover o prefixo "https://" ou "http://"
# Isso não altera a variável original, apenas mostra o resultado
limpa=${url/#https:\/\/}
limpa=${limpa/#http:\/\/}
printf "URL sem protocolo: ${BOLD}$limpa${RESET}\n"

# ----------------------------------------
# Comparação numérica com (( ))
num=10
if (( num > 5 )); then
    echo "Número $num é maior que 5"
fi

# ----------------------------------------
# Substituição de string (exemplo direto)
texto="arquivo_backup.tar.gz"
novo_texto="${texto/backup/seguro}"
echo "Renomeado: $novo_texto"
