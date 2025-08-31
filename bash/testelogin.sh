#!/bin/bash

# Cores
VERDE="\033[32m"
VERMELHO="\033[31m"
AMARELO="\033[33m"
AZUL="\033[34m"
RESET="\033[0m"

login() {
  adm="admin"
  pass="yirefsj"

  usuario="$1"
  senha="$2"

  if [ "$usuario" = "$adm" ] && [ "$senha" = "$pass" ]; then
    return 0
  else
    return 1
  fi
}

MAX_TENTATIVAS=3
tentativas=0

echo -e "${AZUL}=== Sistema de Login ===${RESET}"

while true; do
  ((tentativas++))

  if [ $tentativas -gt $MAX_TENTATIVAS ]; then
    echo -e "${VERMELHO}Número máximo de tentativas atingido. Saindo...${RESET}"
    exit 2
  fi

  read -p "Usuário: " input_user 2> /dev/null
  read -s -p "Senha: " input_pass 2> /dev/null
  echo

  login "$input_user" "$input_pass"

  if [ $? -eq 0 ]; then
    echo -e "${VERDE}✅ Bem-vindo(a), $input_user!${RESET}"
    break
  else
    echo -e "${AMARELO}❌ Usuário ou senha inválidos. Tentativa $tentativas de $MAX_TENTATIVAS.${RESET}"
  fi
done

echo -e "${AZUL}Fim do script.${RESET}"
exit 0
