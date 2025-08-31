#!/bin/bash
# ---------------------------------------------
# Shebang: define que este script será interpretado pelo Bash
# ---------------------------------------------

# ---------------------------------------------
# Definição de variáveis para cores ANSI
# Usadas para colorir textos no terminal
# ---------------------------------------------
YELLOW="\033[93m"
CYAN_LIGHT="\033[96m"
GREEN="\033[92m"
PURPLE="\033[95m"
RED="\033[91m"
BLUE="\033[94m"
RESET="\033[0m"

# ---------------------------------------------
# Pergunta ao usuário o domínio ou URL a ser analisado
# ---------------------------------------------
printf "${YELLOW}Digite o ${CYAN_LIGHT}Dominio/Url ${YELLOW}que deseja analisar:${RESET}\n"
read url

# ---------------------------------------------
# Verifica se a URL começa com "https://"
# Se não começar, adiciona automaticamente
# ---------------------------------------------
if [[ "${url}" != "https://"* ]]; then
  url="https://${url}"
fi

# ---------------------------------------------
# Mostra o link que está sendo analisado
# ---------------------------------------------
printf "${YELLOW}Atualmente analisando o link: ${CYAN_LIGHT}%s${RESET}\n" "$url"

# ---------------------------------------------
# Função: Mostra o menu de opções
# ---------------------------------------------
menu() {
  printf "1-${GREEN}Montar urls${RESET}\n"
  printf "2-${PURPLE}Usar Nuclei ${RED}[ROOT NECESSÁRIO]${RESET}\n"
  printf "3-${BLUE}Subdominios ativos${RESET}\n"
  printf "4-${CYAN_LIGHT}Achar informações no JavaScript${RESET}\n"
  printf "9-${RED}Mudar alvo${RESET}\n"
  printf "00-${YELLOW}Sair${RESET}\n"
}

# ---------------------------------------------
# Função: Monta URLs usando 'gau'
# ---------------------------------------------
acharurls() {
  printf "Montando urls em ${GREEN}%s${RESET}\n" "$url"
  printf "$url" | gau
}

# ---------------------------------------------
# Função: Busca informações em arquivos JavaScript usando 'getJS'
# ---------------------------------------------
javascript() {
  printf "Coletando informações no JavaScript...\n"
  printf "$url" | getJS
}

# ---------------------------------------------
# Função: Executa scans com o Nuclei usando templates escolhidos
# ---------------------------------------------
nuclei() {
  printf "${YELLOW} Quais templates quer usar?${GREEN}\n"
  printf "1-todos\n"
  printf "2-exposures\n"
  printf "3-cves\n"
  printf "4-exposed panels\n"
  printf "5-fuzzing\n"
  printf "6-vulnerabilities${RESET}\n"

  read -r template

  case $template in
    1) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates ;;
    2) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates/exposures ;;
    3) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates/cves ;;
    4) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates/exposed-panels ;;
    5) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates/fuzzing ;;
    6) ~/go/bin/nuclei -u "$url" -t ~/nuclei-templates/vulnerabilities ;;
    *) printf "${YELLOW}Opção inválida ${CYAN_LIGHT}(⁠╯⁠°⁠□⁠°⁠）⁠╯⁠︵⁠┻⁠━⁠┻${RESET}\n" ;;
  esac
}

# ---------------------------------------------
# Função: Busca subdomínios ativos usando 'subfinder' e testa com 'httpx'
# ---------------------------------------------
subd() {
  subfinder -d "${url##https://}" | httpx -sc -title
}

# ---------------------------------------------
# Loop principal: mostra o menu, lê a opção e executa a ação escolhida
# ---------------------------------------------
while true; do
  menu
  read -r opcao

  case $opcao in
    1) acharurls ;;    # Montar URLs
    2) nuclei ;;       # Usar Nuclei
    3) subd ;;         # Encontrar subdomínios ativos
    4) javascript ;;   # Analisar arquivos JavaScript
    9)                 # Mudar o alvo
      printf "${YELLOW}Digite o ${CYAN_LIGHT}Dominio/Url ${YELLOW}que deseja analisar:${RESET}\n"
      read url

      if [[ "${url}" != "https://"* ]]; then
        url="https://${url}"
      fi

      printf "${YELLOW}Atualmente analisando o link: ${CYAN_LIGHT}%s${RESET}\n" "$url"
      ;;
    00)                # Sair do script
      printf "${YELLOW}Saindo...${RESET}\n"
      exit 0
      ;;
    *)                 # Opção inválida
      printf "${YELLOW}Opção inválida ${CYAN_LIGHT}(⁠╯⁠°⁠□⁠°⁠）⁠╯⁠︵⁠┻⁠━⁠┻${RESET}\n"
      ;;
  esac
done
