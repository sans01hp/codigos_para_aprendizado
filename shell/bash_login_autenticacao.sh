#!/bin/bash

################################################################################
#                   LOGIN E AUTENTICAÇÃO - GUIA COMPLETO
#
# Este arquivo consolida exemplos sobre:
# - Validação de credenciais (usuário/senha)
# - Regex para validação de email
# - Contador de tentativas
# - Return codes (0=sucesso, 1=falha)
# - Funções com lógica de login
# - Cores ANSI para feedback visual
################################################################################


###############################################################################
# 📘 PARTE 1: CONCEITOS FUNDAMENTAIS
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║              LOGIN E AUTENTICAÇÃO - CONCEITOS                 ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'CONCEITOS'

═══════════════════════════════════════════════════════════════════
COMPONENTES DE UM SISTEMA DE LOGIN
═══════════════════════════════════════════════════════════════════

1. Validação de entrada
   - Verificar se campos não estão vazios
   - Validar formato (email, username, etc)
   - Sanitizar entrada

2. Verificação de credenciais
   - Comparar usuário/senha com base de dados
   - Return code 0 = sucesso, 1 = falha

3. Contador de tentativas
   - Limitar número de tentativas (ex: máximo 3)
   - Bloquear após limite excedido

4. Feedback ao usuário
   - Mensagens de sucesso/erro
   - Cores ANSI para melhor legibilidade
   - Emojis para clareza visual

═══════════════════════════════════════════════════════════════════
VALIDAÇÃO DE EMAIL COM REGEX
═══════════════════════════════════════════════════════════════════

Padrão básico:
   ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$

Explicação:
   ^                    → Início da string
   [a-zA-Z0-9._%+-]+    → Usuário (letras, números, . _ % + -)
   @                    → Símbolo @
   [a-zA-Z0-9.-]+       → Domínio
   \.                   → Ponto literal
   [a-zA-Z]{2,}         → Extensão (.com, .br, etc) - 2+ letras
   $                    → Fim da string

═══════════════════════════════════════════════════════════════════
RETURN CODES
═══════════════════════════════════════════════════════════════════

Em bash:
   return 0  → Sucesso (true)
   return 1  → Falha (false)
   $?        → Variável com código da última função/comando

Exemplo:
   if funcao_login; then
       echo "Login bem-sucedido"  # $? == 0
   else
       echo "Falha no login"      # $? == 1
   fi

═══════════════════════════════════════════════════════════════════
CORES ANSI PARA FEEDBACK
═══════════════════════════════════════════════════════════════════

RED="\033[0;31m"      # Vermelho
GREEN="\033[0;32m"    # Verde
YELLOW="\033[1;33m"   # Amarelo (bold)
RESET="\033[0m"       # Reset

Exemplo:
   printf "%b${GREEN}✓ Sucesso${RESET}\n" ""
   printf "%b${RED}✗ Erro${RESET}\n" ""

═══════════════════════════════════════════════════════════════════
FLUXO DE LOGIN
═══════════════════════════════════════════════════════════════════

1. Solicitar entrada (usuário, senha, email)
2. Validar formato da entrada
3. Verificar credenciais
4. Se falhar, permitir nova tentativa
5. Se máximo de tentativas atingido, sair
6. Se sucesso, retornar código 0

CONCEITOS


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

# Cores ANSI
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - LOGIN E AUTENTICAÇÃO"
echo "═══════════════════════════════════════════════════════════════════"

# --- EXEMPLO 1: Validação de email ---
echo ""
echo "🔹 EXEMPLO 1: Validação de email"
echo "─────────────────────────────────────────────────────────────────"

validar_email() {
    local email="$1"
    
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        printf "%b${GREEN}✓ Email válido: %s${RESET}\n" "" "$email"
        return 0
    else
        printf "%b${RED}✗ Email inválido: %s${RESET}\n" "" "$email"
        return 1
    fi
}

validar_email "user@example.com"
validar_email "invalid.email"
validar_email "admin@company.com.br"


# --- EXEMPLO 2: Login simples com verificação ---
echo ""
echo "🔹 EXEMPLO 2: Sistema de login simples"
echo "─────────────────────────────────────────────────────────────────"

# Credenciais hardcoded (apenas para exemplo educacional)
USUARIO_VALIDO="admin"
SENHA_VALIDA="adm123"

fazer_login() {
    local usuario="$1"
    local senha="$2"
    
    # Verificar se campos não estão vazios
    if [[ -z "$usuario" || -z "$senha" ]]; then
        printf "%b${RED}✗ Usuário ou senha faltando${RESET}\n" ""
        return 1
    fi
    
    # Verificar credenciais
    if [[ "$usuario" == "$USUARIO_VALIDO" && "$senha" == "$SENHA_VALIDA" ]]; then
        printf "%b${GREEN}✓ Login bem-sucedido!${RESET}\n" ""
        printf "%b${BLUE}Bem-vindo, %s!${RESET}\n" "" "$usuario"
        return 0
    else
        printf "%b${RED}✗ Usuário ou senha inválidos${RESET}\n" ""
        return 1
    fi
}

# Simular login
fazer_login "admin" "adm123"
fazer_login "admin" "errada"
fazer_login "" "senha"


# --- EXEMPLO 3: Login com validação de email ---
echo ""
echo "🔹 EXEMPLO 3: Login com email válido"
echo "─────────────────────────────────────────────────────────────────"

login_por_email() {
    local email="$1"
    local senha="$2"
    
    # Validar email primeiro
    if ! validar_email "$email"; then
        return 1
    fi
    
    # Se email é válido, verificar credenciais
    if fazer_login "$email" "$senha"; then
        return 0
    else
        return 1
    fi
}

login_por_email "admin@example.com" "senha123"


# --- EXEMPLO 4: Contador de tentativas ---
echo ""
echo "🔹 EXEMPLO 4: Login com contador de tentativas"
echo "─────────────────────────────────────────────────────────────────"

MAX_TENTATIVAS=3

fazer_login_com_limite() {
    local tentativa=0
    
    while [[ $tentativa -lt $MAX_TENTATIVAS ]]; do
        ((tentativa++))
        printf "\n%b${YELLOW}Tentativa %d/%d${RESET}\n" "" "$tentativa" "$MAX_TENTATIVAS"
        
        # Simulamos entrada (em um script real seria read)
        # Por simplicidade, usamos valores hardcoded
        if [[ $tentativa -eq 1 ]]; then
            fazer_login "admin" "errada"
        elif [[ $tentativa -eq 2 ]]; then
            fazer_login "admin" "outra_errada"
        else
            fazer_login "admin" "adm123"
        fi
        
        if [[ $? -eq 0 ]]; then
            return 0
        fi
    done
    
    printf "%b${RED}✗ Número máximo de tentativas excedido!${RESET}\n" ""
    return 1
}

fazer_login_com_limite


# --- EXEMPLO 5: Validação de username ---
echo ""
echo "🔹 EXEMPLO 5: Validação de username"
echo "─────────────────────────────────────────────────────────────────"

validar_username() {
    local username="$1"
    
    # Username deve ter 3-20 caracteres, apenas letras, números e underscore
    if [[ $username =~ ^[a-zA-Z0-9_]{3,20}$ ]]; then
        printf "%b${GREEN}✓ Username válido: %s${RESET}\n" "" "$username"
        return 0
    else
        printf "%b${RED}✗ Username inválido (3-20 chars, alphanumeric + _)${RESET}\n" ""
        return 1
    fi
}

validar_username "john_doe"
validar_username "ab"
validar_username "john@doe"
validar_username "valid_123"


# --- EXEMPLO 6: Validação de senha forte ---
echo ""
echo "🔹 EXEMPLO 6: Validação de senha forte"
echo "─────────────────────────────────────────────────────────────────"

validar_senha_forte() {
    local senha="$1"
    
    # Mínimo 8 caracteres
    if [[ ${#senha} -lt 8 ]]; then
        printf "%b${RED}✗ Senha deve ter no mínimo 8 caracteres${RESET}\n" ""
        return 1
    fi
    
    # Deve ter maiúsculas
    if [[ ! $senha =~ [A-Z] ]]; then
        printf "%b${RED}✗ Senha deve conter maiúsculas${RESET}\n" ""
        return 1
    fi
    
    # Deve ter minúsculas
    if [[ ! $senha =~ [a-z] ]]; then
        printf "%b${RED}✗ Senha deve conter minúsculas${RESET}\n" ""
        return 1
    fi
    
    # Deve ter números
    if [[ ! $senha =~ [0-9] ]]; then
        printf "%b${RED}✗ Senha deve conter números${RESET}\n" ""
        return 1
    fi
    
    printf "%b${GREEN}✓ Senha forte!${RESET}\n" ""
    return 0
}

echo "Testando senhas:"
validar_senha_forte "senha123"
validar_senha_forte "SenhaForte123"
validar_senha_forte "ABC"


# --- EXEMPLO 7: Sistema completo de autenticação ---
echo ""
echo "🔹 EXEMPLO 7: Sistema completo de autenticação"
echo "─────────────────────────────────────────────────────────────────"

autenticar_usuario() {
    local usuario="$1"
    local senha="$2"
    local email="$3"
    
    printf "%n%b${BLUE}═══ Autenticação ═══${RESET}\n" ""
    
    # 1. Validar username
    if ! validar_username "$usuario"; then
        return 1
    fi
    
    # 2. Validar senha forte
    if ! validar_senha_forte "$senha"; then
        return 1
    fi
    
    # 3. Validar email (se fornecido)
    if [[ -n "$email" ]]; then
        if ! validar_email "$email"; then
            return 1
        fi
    fi
    
    # 4. Fazer login
    if fazer_login "$usuario" "$senha"; then
        printf "%b${GREEN}✓ Autenticação completa!${RESET}\n" ""
        return 0
    fi
    
    return 1
}

# Testar sistema completo
echo ""
autenticar_usuario "john_doe" "SenhaForte123" "john@example.com"


# --- EXEMPLO 8: Menu de login interativo ---
echo ""
echo "🔹 EXEMPLO 8: Menu de login"
echo "─────────────────────────────────────────────────────────────────"

menu_principal() {
    clear
    printf "%b${BLUE}╔════════════════════════════════════╗${RESET}\n" ""
    printf "%b${BLUE}║       SISTEMA DE LOGIN BASH        ║${RESET}\n" ""
    printf "%b${BLUE}╚════════════════════════════════════╝${RESET}\n" ""
    
    printf "\n1. Login com username\n"
    printf "2. Login com email\n"
    printf "3. Sair\n"
    printf "\nEscolha uma opção: "
}

# Simulação de menu (em um script real seria read -p)
echo "Menu simulado:"
menu_principal


###############################################################################
# 📊 PARTE 3: TABELA DE REFERÊNCIA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌──────────────────────┬────────────────────┬──────────────────────────┐
│ Tarefa               │ Função/Comando     │ Exemplo                  │
├──────────────────────┼────────────────────┼──────────────────────────┤
│ Validar email        │ =~ regex           │ [[ $email =~ ^.*@.*$ ]]  │
│ Validar username     │ =~ regex           │ [[ $user =~ ^[a-z]+$ ]]  │
│ Validar senha        │ length + =~        │ [[ ${#pass} -ge 8 ]]     │
│ Comparar strings     │ ==                 │ [[ "$user" == "admin" ]] │
│ Retornar sucesso     │ return 0           │ if ok; then return 0; fi │
│ Retornar erro        │ return 1           │ if fail; then return 1   │
│ Contar tentativas    │ contador           │ ((tentativa++))          │
│ Limite de tentativas │ -lt, -ge, -le      │ [[ $tentativa -lt 3 ]]   │
│ Cores ANSI verde     │ \033[0;32m         │ printf "%b${GREEN}ok"    │
│ Cores ANSI vermelho  │ \033[0;31m         │ printf "%b${RED}erro"    │
│ Cores ANSI reset     │ \033[0m            │ printf "%b${RESET}"      │
│                      │                    │                          │
└──────────────────────┴────────────────────┴──────────────────────────┘

TABELA

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
