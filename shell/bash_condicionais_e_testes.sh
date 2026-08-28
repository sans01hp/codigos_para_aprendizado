#!/bin/bash

################################################################################
#                   CONDICIONAIS E TESTES - GUIA COMPLETO
#
# Este arquivo consolida exemplos e boas práticas sobre:
# - Testes com [ ] e [[ ]]
# - Comparações numéricas e de strings
# - Testes de arquivos e diretórios
# - Operadores lógicos (&&, ||, -a, -o)
# - Funções com validação
# - Loops com condições
################################################################################


###############################################################################
# 📘 PARTE 1: RESUMO TEÓRICO - COMPARAÇÕES EM BASH
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║           COMPARAÇÕES E OPERADORES CONDICIONAIS               ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'TEORIA'

═══════════════════════════════════════════════════════════════════
1. COMPARAÇÕES NUMÉRICAS
═══════════════════════════════════════════════════════════════════

→ Com [ ] (POSIX - compatível com tudo):
  Operadores: -eq, -ne, -lt, -le, -gt, -ge
  Exemplo: [ "$a" -lt "$b" ]
  ✓ Funciona em sh, bash, zsh
  ✗ Precisa de aspas nas variáveis

→ Com (( )) (Moderno e prático):
  Operadores: ==, !=, <, <=, >, >=
  Exemplo: (( a > b ))
  ✓ Mais legível, suporta operações matemáticas
  ✗ Só funciona em bash/zsh (não em sh)

Exemplos:
  if [ "$NUM1" -eq "$NUM2" ]; then   # [ ] com -eq
  if (( NUM1 == NUM2 )); then        # (( )) com ==

═══════════════════════════════════════════════════════════════════
2. COMPARAÇÕES DE STRINGS
═══════════════════════════════════════════════════════════════════

→ Com [ ]:
  Operadores: =, !=, -z (vazio), -n (não vazio)
  Exemplo: [ "$str1" = "$str2" ]

→ Com [[ ]] (Recomendado):
  Operadores: ==, !=, =~, -z, -n, patterns (glob)
  ✓ Suporta regex com =~
  ✓ Suporta padrões glob (wildcard)
  ✓ Mais seguro com espaços em branco
  Exemplo: [[ "$str" =~ ^[a-z]+$ ]]

Exemplos:
  [[ -z "$VAR" ]]           # String vazia
  [[ -n "$VAR" ]]           # String não vazia
  [[ "$str" == "texto" ]]   # Igualdade
  [[ "$str" =~ ^[a-z]+$ ]]  # Regex

═══════════════════════════════════════════════════════════════════
3. TESTES DE ARQUIVOS
═══════════════════════════════════════════════════════════════════

  -e arquivo    → Existe (arquivo ou diretório)
  -f arquivo    → É arquivo regular
  -d arquivo    → É diretório
  -s arquivo    → Não está vazio
  -r arquivo    → Tem permissão de leitura
  -w arquivo    → Tem permissão de escrita
  -x arquivo    → É executável

Exemplo:
  if [ -f "$arquivo" ]; then
    echo "É um arquivo regular"
  fi

═══════════════════════════════════════════════════════════════════
4. LÓGICA BOOLEANA (AND, OR, NOT)
═══════════════════════════════════════════════════════════════════

→ Com [ ] (POSIX):
  -a  (AND)   [ "$a" -lt "$b" -a "$b" -gt 8 ]
  -o  (OR)    [ "$a" -gt "$b" -o "$a" -eq 5 ]
  !   (NOT)   [ ! -e "$arquivo" ]

→ Com [[ ]] (Moderno e legível):
  &&  (AND)   [[ "$a" -lt "$b" && "$b" -gt 8 ]]
  ||  (OR)    [[ "$a" -gt "$b" || "$a" -eq 5 ]]
  !   (NOT)   [[ ! "$var" == "admin" ]]

═══════════════════════════════════════════════════════════════════
✅ BOAS PRÁTICAS
═══════════════════════════════════════════════════════════════════

1. SEMPRE USE [[ ... ]] PARA NOVOS SCRIPTS
   - Mais moderno e seguro
   - Suporta regex e glob patterns
   - Melhor tratamento de espaços

2. USE -z E -n PARA STRINGS
   [[ -z "$entrada" ]] && echo "Vazio"
   [[ -n "$entrada" ]] && echo "Preenchido"

3. USE SEMPRE ASPAS EM VARIÁVEIS
   CERTO:   [[ "$var" == "x" ]]
   ERRADO:  [[ $var == x ]]

4. AGRUPE CONDIÇÕES COM CLAREZA
   if [[ -n "$user" && "$user" != "root" ]]; then
       echo "Usuário válido"
   fi

5. USE (( )) PARA COMPARAÇÕES NUMÉRICAS
   if (( idade >= 18 )); then
       echo "Maior de idade"
   fi

6. COMENTE CONDIÇÕES COMPLEXAS
   if [[ "$linha" =~ ^# ]]; then
       # Ignora linhas que começam com #
       continue
   fi

7. USE : COMO PLACEHOLDER PARA BLOCOS VAZIOS
   if [[ "$DEBUG" == "on" ]]; then
       : # Sem ação por enquanto (será implementado)
   fi

TEORIA


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - Testando Strings, Números e Arquivos"
echo "═══════════════════════════════════════════════════════════════════"

# Dados de teste
VAR1="texto"
VAR2=""
NUM1=5
NUM2=10
ARQUIVO="/etc/passwd"
PASTA="/tmp"

# --- TESTES COM STRINGS ---
echo ""
echo "🔹 TESTES COM STRINGS"
echo "─────────────────────────────────────────────────────────────────"

# -z testa se a string está vazia
if [[ -z "$VAR2" ]]; then
  echo "✓ VAR2 está vazia"
fi

# -n testa se a string NÃO está vazia
if [[ -n "$VAR1" ]]; then
  echo "✓ VAR1 não está vazia: '$VAR1'"
fi

# Igualdade de strings
if [[ "$VAR1" == "texto" ]]; then
  echo "✓ VAR1 é igual a 'texto'"
fi

# Diferença de strings
if [[ "$VAR1" != "outra" ]]; then
  echo "✓ VAR1 não é 'outra'"
fi

# Verificar se começa com um padrão (glob)
if [[ "$VAR1" == tex* ]]; then
  echo "✓ VAR1 começa com 'tex'"
fi

# --- TESTES COM NÚMEROS ---
echo ""
echo "🔹 TESTES COM NÚMEROS"
echo "─────────────────────────────────────────────────────────────────"

# Igualdade numérica (com [ ])
if [ "$NUM1" -eq 5 ]; then
  echo "✓ NUM1 é igual a 5 (usando [ -eq ])"
fi

# Igualdade numérica (com (( )))
if (( NUM1 == 5 )); then
  echo "✓ NUM1 é igual a 5 (usando (( == )))"
fi

# Comparações
if (( NUM1 < NUM2 )); then
  echo "✓ NUM1 ($NUM1) é menor que NUM2 ($NUM2)"
fi

if (( NUM1 <= 5 )); then
  echo "✓ NUM1 é menor ou igual a 5"
fi

# Operações matemáticas
if (( NUM1 + NUM2 == 15 )); then
  echo "✓ NUM1 + NUM2 = 15"
fi

# --- TESTES COM ARQUIVOS ---
echo ""
echo "🔹 TESTES COM ARQUIVOS E DIRETÓRIOS"
echo "─────────────────────────────────────────────────────────────────"

# Arquivo existe?
if [[ -e "$ARQUIVO" ]]; then
  echo "✓ O arquivo $ARQUIVO existe"
fi

# É um arquivo regular?
if [[ -f "$ARQUIVO" ]]; then
  echo "✓ $ARQUIVO é um arquivo regular"
fi

# É um diretório?
if [[ -d "$PASTA" ]]; then
  echo "✓ $PASTA é um diretório"
fi

# Tem permissão de leitura?
if [[ -r "$ARQUIVO" ]]; then
  echo "✓ Você tem permissão para ler $ARQUIVO"
fi

# Tem permissão de escrita?
if [[ -w "$PASTA" ]]; then
  echo "✓ Você tem permissão para escrever em $PASTA"
fi

# --- TESTES LÓGICOS ---
echo ""
echo "🔹 TESTES LÓGICOS (AND, OR, NOT)"
echo "─────────────────────────────────────────────────────────────────"

# AND - Ambas as condições precisam ser verdadeiras
if [[ "$NUM1" -lt "$NUM2" && "$VAR1" == "texto" ]]; then
  echo "✓ NUM1 < NUM2 E VAR1 é 'texto' (AND verdadeiro)"
fi

# OR - Pelo menos uma condição é verdadeira
if [[ "$NUM1" -gt "$NUM2" || -z "$VAR2" ]]; then
  echo "✓ NUM1 > NUM2 OU VAR2 vazia (OR verdadeiro)"
fi

# NOT - Inverte a condição
if [[ ! "$VAR1" == "outra" ]]; then
  echo "✓ VAR1 não é 'outra' (NOT verdadeiro)"
fi

# Negação com teste de arquivo
if [[ ! -e "/arquivo/inexistente" ]]; then
  echo "✓ /arquivo/inexistente não existe (arquivo NÃO existe)"
fi


###############################################################################
# 🔧 PARTE 3: FUNÇÕES COM VALIDAÇÃO
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "FUNÇÕES COM VALIDAÇÃO"
echo "═══════════════════════════════════════════════════════════════════"

# Validar email com regex
validar_email() {
  local email="$1"
  
  if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "✓ Email válido: $email"
    return 0
  else
    echo "✗ Email inválido: $email"
    return 1
  fi
}

# Validar nome de usuário (apenas letras, números e underscore)
validar_usuario() {
  local usuario="$1"
  
  if [[ $usuario =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "✓ Usuário válido: $usuario"
    return 0
  else
    echo "✗ Usuário deve conter apenas letras, números e underscore"
    return 1
  fi
}

# Validar idade (número entre 0 e 150)
validar_idade() {
  local idade="$1"
  
  if [[ $idade =~ ^[0-9]+$ ]] && (( idade >= 0 && idade <= 150 )); then
    echo "✓ Idade válida: $idade"
    return 0
  else
    echo "✗ Idade inválida"
    return 1
  fi
}

# Função que verifica se arquivo existe e é legível
arquivo_ok() {
  local arquivo="$1"
  
  if [[ -f "$arquivo" && -r "$arquivo" ]]; then
    echo "✓ Arquivo $arquivo existe e é legível"
    return 0
  else
    echo "✗ Arquivo não encontrado ou não legível"
    return 1
  fi
}

# Executar exemplos de funções
echo ""
echo "Testando validação de email:"
validar_email "user@example.com"
validar_email "invalid.email"

echo ""
echo "Testando validação de usuário:"
validar_usuario "admin_user"
validar_usuario "admin@123"

echo ""
echo "Testando validação de idade:"
validar_idade 25
validar_idade 200

echo ""
echo "Testando verificação de arquivo:"
arquivo_ok "/etc/passwd"
arquivo_ok "/arquivo/inexistente"


###############################################################################
# 🔄 PARTE 4: LOOPS COM CONDIÇÕES
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "LOOPS COM CONDIÇÕES"
echo "═══════════════════════════════════════════════════════════════════"

# Loop for com condição
echo ""
echo "🔹 Loop FOR com verificação"
for i in {1..5}; do
  if (( i % 2 == 0 )); then
    echo "  $i é par"
  else
    echo "  $i é ímpar"
  fi
done

# Loop while com contador
echo ""
echo "🔹 Loop WHILE com contagem regressiva"
contador=3
while [[ $contador -gt 0 ]]; do
  echo "  Contando: $contador"
  ((contador--))
done
echo "  🎉 Lançamento!"

# Simulando menu com case e if
echo ""
echo "🔹 Menu simples com validação"
menu() {
  local opcao="$1"
  
  case "$opcao" in
    1)
      if [[ -n "$opcao" ]]; then
        echo "  ✓ Opção 1 selecionada"
      fi
      ;;
    2)
      echo "  ✓ Opção 2 selecionada"
      ;;
    *)
      if [[ ! "$opcao" =~ ^[12]$ ]]; then
        echo "  ✗ Opção inválida"
        return 1
      fi
      ;;
  esac
}

menu 1
menu 2
menu 3


###############################################################################
# 📊 PARTE 5: TABELA DE REFERÊNCIA RÁPIDA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA RÁPIDA"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌─────────────────┬──────────────────────┬─────────────────────────────┐
│ Tipo de Teste   │ Operador             │ Exemplo                     │
├─────────────────┼──────────────────────┼─────────────────────────────┤
│ Strings (vazio) │ -z "$var"            │ [[ -z "$var" ]]             │
│ Strings (cheio) │ -n "$var"            │ [[ -n "$var" ]]             │
│ Igualdade       │ == ou =              │ [[ "$a" == "$b" ]]          │
│ Diferença       │ != ou !=             │ [[ "$a" != "$b" ]]          │
│ Regex           │ =~                   │ [[ "$str" =~ ^[a-z]+$ ]]    │
│                 │                      │                             │
│ Números (eq)    │ -eq                  │ [ "$a" -eq "$b" ]           │
│ Números (ne)    │ -ne                  │ [ "$a" -ne "$b" ]           │
│ Números (lt)    │ -lt                  │ [ "$a" -lt "$b" ]           │
│ Números (le)    │ -le                  │ [ "$a" -le "$b" ]           │
│ Números (gt)    │ -gt                  │ [ "$a" -gt "$b" ]           │
│ Números (ge)    │ -ge                  │ [ "$a" -ge "$b" ]           │
│                 │                      │                             │
│ Aritmética      │ ==, !=, <, >, <=, >= │ (( a < b ))                 │
│ Incremento      │ ++                   │ (( x++ ))                   │
│ Decremento      │ --                   │ (( x-- ))                   │
│                 │                      │                             │
│ Arquivo existe  │ -e                   │ [[ -e "$file" ]]            │
│ É arquivo       │ -f                   │ [[ -f "$file" ]]            │
│ É diretório     │ -d                   │ [[ -d "$dir" ]]             │
│ Não vazio       │ -s                   │ [[ -s "$file" ]]            │
│ Legível         │ -r                   │ [[ -r "$file" ]]            │
│ Gravável        │ -w                   │ [[ -w "$file" ]]            │
│ Executável      │ -x                   │ [[ -x "$file" ]]            │
│                 │                      │                             │
│ AND             │ &&                   │ [[ "$a" == "x" && -f "$f" ]]│
│ OR              │ ||                   │ [[ "$a" == "x" || -z "$b" ]]│
│ NOT             │ !                    │ [[ ! "$a" == "x" ]]         │
│                 │                      │                             │
└─────────────────┴──────────────────────┴─────────────────────────────┘

TABELA

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
