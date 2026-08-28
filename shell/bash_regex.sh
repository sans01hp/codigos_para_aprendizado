#!/bin/bash

################################################################################
#                   REGEX - EXPRESSÕES REGULARES - GUIA COMPLETO
#
# Este arquivo consolida exemplos sobre:
# - Sintaxe regex em Bash [[ $var =~ regex ]]
# - Metacaracteres (^, $, ., *, +, [], (), etc)
# - Glob patterns vs Regex
# - Captura de grupos com BASH_REMATCH
# - Validação de strings (email, telefone, URL, etc)
# - Exemplos práticos
################################################################################


###############################################################################
# 📘 PARTE 1: CONCEITOS FUNDAMENTAIS
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║              REGEX - EXPRESSÕES REGULARES BASH                ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'CONCEITOS'

═══════════════════════════════════════════════════════════════════
O QUE É REGEX?
═══════════════════════════════════════════════════════════════════

Regex (Regular Expression) é um padrão de texto para:
- Validar formatos de strings
- Extrair partes de uma string
- Procurar por padrões específicos
- Substituir texto

Sintaxe em Bash:
   if [[ "$string" =~ ^padrão$ ]]; then
       # Casou com o padrão
   fi

═══════════════════════════════════════════════════════════════════
METACARACTERES E QUANTIFICADORES
═══════════════════════════════════════════════════════════════════

POSIÇÃO:
  ^       → Início da string
  $       → Fim da string
  \<      → Início de palavra
  \>      → Fim de palavra

CARACTERES:
  .       → Qualquer caractere único (exceto \n)
  [abc]   → Qualquer caractere dentro dos colchetes
  [a-z]   → Intervalo: letras de a a z
  [^abc]  → Negação: qualquer caractere EXCETO a, b, c
  \\      → Escape: para usar caracteres especiais literalmente

QUANTIFICADORES:
  *       → Zero ou mais ocorrências
  +       → Uma ou mais ocorrências
  ?       → Zero ou uma ocorrência
  {n}     → Exatamente n ocorrências
  {n,}    → N ou mais ocorrências
  {n,m}   → Entre n e m ocorrências

EXEMPLOS:
  a*      → "a", "", "aaa" (zero ou mais 'a')
  a+      → "a", "aaa" (uma ou mais 'a')
  a?      → "a" ou "" (opcionalmente 'a')
  [0-9]{2} → Exatamente 2 dígitos (00-99)
  [a-z]+   → Uma ou mais letras minúsculas

═══════════════════════════════════════════════════════════════════
CLASSES DE CARACTERES
═══════════════════════════════════════════════════════════════════

[a-z]    → Letras minúsculas
[A-Z]    → Letras maiúsculas
[0-9]    → Dígitos
[a-zA-Z0-9] → Alfanuméricos
[[:alpha:]] → Qualquer letra (a-z, A-Z)
[[:digit:]] → Qualquer dígito (0-9)
[[:alnum:]] → Letras e dígitos
[[:space:]] → Espaço em branco

═══════════════════════════════════════════════════════════════════
GRUPOS E CAPTURA
═══════════════════════════════════════════════════════════════════

Use ( ) para criar grupos capturáveis:
   if [[ "$str" =~ ^([a-z]+)([0-9]+)$ ]]; then
       echo "Grupo 1: ${BASH_REMATCH[1]}"  # Parte com letras
       echo "Grupo 2: ${BASH_REMATCH[2]}"  # Parte com números
   fi

BASH_REMATCH é um array:
  BASH_REMATCH[0] → Toda a string que casou
  BASH_REMATCH[1] → Primeiro grupo ( )
  BASH_REMATCH[2] → Segundo grupo ( )
  ... e assim por diante

═══════════════════════════════════════════════════════════════════
GLOB vs REGEX
═══════════════════════════════════════════════════════════════════

GLOB (usado com ==, !=):
  *.txt        → Qualquer arquivo terminado em .txt
  test?        → test1, test2, testa
  [abc]*       → Começa com a, b ou c

REGEX (usado com =~):
  .*\.txt$     → Termina com .txt
  test[0-9]    → test0-test9
  ^[abc].*     → Começa com a, b ou c

Diferenças principais:
  Glob usa padrões simples, mais limitado
  Regex é mais poderoso e flexível

═══════════════════════════════════════════════════════════════════
CASOS DE USO COMUNS
═══════════════════════════════════════════════════════════════════

EMAIL:
  ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$

TELEFONE (com parênteses):
  ^\([0-9]{2}\) [0-9]{4,5}-[0-9]{4}$

URL com HTTPS:
  ^https://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}

DATA (DD/MM/YYYY):
  ^[0-3][0-9]/[0-1][0-9]/[0-9]{4}$

HORA (HH:MM):
  ^[0-2][0-9]:[0-5][0-9]$

NÚMEROS INTEIROS:
  ^[0-9]+$

NÚMEROS COM DECIMAL:
  ^[0-9]+\.[0-9]+$

USERNAME (letras, números, underscore):
  ^[a-zA-Z0-9_]+$

═══════════════════════════════════════════════════════════════════
DICAS IMPORTANTES
═══════════════════════════════════════════════════════════════════

1. Use ^ e $ para validar a TODA a string
   [[ "$num" =~ ^[0-9]+$ ]]  ✓ Correto (toda a string)
   [[ "$num" =~ [0-9]+ ]]    ✗ Incompleto (apenas contém números)

2. Escape caracteres especiais com \\
   [[ "$url" =~ \.com$ ]]    ✓ Ponto literal
   [[ "$url" =~ .com$ ]]     ✗ Qualquer caractere

3. Use [[ ]] sempre, nunca [ ]
   [[ "$str" =~ regex ]]     ✓ Bash/Zsh moderno
   [ "$str" =~ regex ]       ✗ Não funciona em [ ]

CONCEITOS


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - REGEX"
echo "═══════════════════════════════════════════════════════════════════"

# --- EXEMPLO 1: Verificações básicas ---
echo ""
echo "🔹 EXEMPLO 1: Verificações básicas"
echo "─────────────────────────────────────────────────────────────────"

texto="abc123"
num="4567"
email="user@example.com"
telefone="(11) 91234-5678"

echo "String: $texto"
if [[ $texto =~ [0-9]+ ]]; then
  echo "  ✓ Contém números"
fi

echo ""
echo "String: $num"
if [[ $num =~ ^[0-9]+$ ]]; then
  echo "  ✓ É um número inteiro"
fi

echo ""
echo "Email: $email"
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  echo "  ✓ Parece um email válido"
fi

echo ""
echo "Telefone: $telefone"
if [[ $telefone =~ ^\([0-9]{2}\)\ [0-9]{4,5}-[0-9]{4}$ ]]; then
  echo "  ✓ Formato de telefone válido"
fi


# --- EXEMPLO 2: Entrada do usuário com validação ---
echo ""
echo "🔹 EXEMPLO 2: Validação com entrada interativa"
echo "─────────────────────────────────────────────────────────────────"

validar_nome_usuario() {
    local nome="$1"
    
    if [[ "$nome" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "  ✓ Nome de usuário válido"
        return 0
    else
        echo "  ✗ Inválido. Use apenas letras, números e underscore (_)"
        return 1
    fi
}

echo "Testando nomes de usuário:"
validar_nome_usuario "admin_user"
validar_nome_usuario "user.123"
validar_nome_usuario "valid_123"


# --- EXEMPLO 3: Captura de grupos ---
echo ""
echo "🔹 EXEMPLO 3: Captura de grupos com BASH_REMATCH"
echo "─────────────────────────────────────────────────────────────────"

texto2="abc123def"
echo "String: $texto2"

if [[ $texto2 =~ ([a-z]+)([0-9]+)([a-z]+) ]]; then
  echo "  ✓ Padrão casou!"
  echo "    Grupo 1 (letras): ${BASH_REMATCH[1]}"
  echo "    Grupo 2 (números): ${BASH_REMATCH[2]}"
  echo "    Grupo 3 (letras): ${BASH_REMATCH[3]}"
  echo "    String completa: ${BASH_REMATCH[0]}"
fi


# --- EXEMPLO 4: Extrair email de texto ---
echo ""
echo "🔹 EXEMPLO 4: Extrair email de texto"
echo "─────────────────────────────────────────────────────────────────"

frase="Envie para suporte@empresa.com.br ou admin@example.com"
echo "Texto: $frase"

if [[ $frase =~ ([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}) ]]; then
  echo "  ✓ Email encontrado: ${BASH_REMATCH[1]}"
fi


# --- EXEMPLO 5: Validação de URL ---
echo ""
echo "🔹 EXEMPLO 5: Validação de URL"
echo "─────────────────────────────────────────────────────────────────"

validar_url() {
    local url="$1"
    
    if [[ $url =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
        echo "  ✓ URL válida"
        return 0
    else
        echo "  ✗ URL inválida"
        return 1
    fi
}

echo "Testando URLs:"
validar_url "https://google.com"
validar_url "http://github.com/user/repo"
validar_url "ftp://files.org"
validar_url "invalid.url"


# --- EXEMPLO 6: Procurar por número em uma string ---
echo ""
echo "🔹 EXEMPLO 6: Procurar por números"
echo "─────────────────────────────────────────────────────────────────"

stringsComNumeros=(
    "Produto 123"
    "Código AB456CD"
    "Nenhum número aqui"
    "2024 é o ano"
)

for str in "${stringsComNumeros[@]}"; do
    if [[ $str =~ [0-9]+ ]]; then
        echo "  ✓ '$str' contém número(s)"
    else
        echo "  ✗ '$str' não contém números"
    fi
done


# --- EXEMPLO 7: Converter número com validação ---
echo ""
echo "🔹 EXEMPLO 7: Validar e converter para maiúsculas"
echo "─────────────────────────────────────────────────────────────────"

processar_valor() {
    local valor="$1"
    
    if [[ $valor =~ ^[a-z]+$ ]]; then
        # Se é somente letras minúsculas
        echo "  Convertendo: $valor → ${valor^^}"  # ^^ converte para maiúsculas
    else
        echo "  ✗ Não é válido"
    fi
}

processar_valor "hello"
processar_valor "Hello"
processar_valor "123"


# --- EXEMPLO 8: Data em formato DD/MM/YYYY ---
echo ""
echo "🔹 EXEMPLO 8: Validação de data"
echo "─────────────────────────────────────────────────────────────────"

validar_data() {
    local data="$1"
    
    if [[ $data =~ ^([0-3][0-9])/([0-1][0-9])/([0-9]{4})$ ]]; then
        echo "  ✓ Data válida: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]}/${BASH_REMATCH[3]}"
        return 0
    else
        echo "  ✗ Data inválida"
        return 1
    fi
}

echo "Testando datas:"
validar_data "12/05/2024"
validar_data "31/12/2023"
validar_data "45/13/2024"


# --- EXEMPLO 9: Hora em formato HH:MM ---
echo ""
echo "🔹 EXEMPLO 9: Validação de hora"
echo "─────────────────────────────────────────────────────────────────"

validar_hora() {
    local hora="$1"
    
    if [[ $hora =~ ^([0-2][0-9]):([0-5][0-9])$ ]]; then
        echo "  ✓ Hora válida: ${BASH_REMATCH[1]}:${BASH_REMATCH[2]}"
        return 0
    else
        echo "  ✗ Hora inválida"
        return 1
    fi
}

echo "Testando horas:"
validar_hora "14:30"
validar_hora "09:00"
validar_hora "25:61"


# --- EXEMPLO 10: Extrair múltiplos valores ---
echo ""
echo "🔹 EXEMPLO 10: Extrair valores de uma string estruturada"
echo "─────────────────────────────────────────────────────────────────"

log_entry="2024-05-12 14:30:45 ERROR [Database] Conexão perdida"
echo "Log: $log_entry"

if [[ $log_entry =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})\ ([0-9]{2}):([0-9]{2}):([0-9]{2})\ ([A-Z]+)\ \[(.*)\]\ (.*)$ ]]; then
    echo "  ✓ Valores extraídos:"
    echo "    Data: ${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]}"
    echo "    Hora: ${BASH_REMATCH[4]}:${BASH_REMATCH[5]}:${BASH_REMATCH[6]}"
    echo "    Nível: ${BASH_REMATCH[7]}"
    echo "    Módulo: ${BASH_REMATCH[8]}"
    echo "    Mensagem: ${BASH_REMATCH[9]}"
fi


###############################################################################
# 🔄 PARTE 3: GLOB VS REGEX
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "GLOB vs REGEX"
echo "═══════════════════════════════════════════════════════════════════"

echo ""
echo "🔹 GLOB (com ==) - mais simples"
echo "─────────────────────────────────────────────────────────────────"

file="documento.txt"

echo "Arquivo: $file"

if [[ "$file" == *.txt ]]; then
  echo "  ✓ Termina com .txt (glob)"
fi

if [[ "$file" == doc* ]]; then
  echo "  ✓ Começa com doc (glob)"
fi

if [[ "$file" == *ment* ]]; then
  echo "  ✓ Contém 'ment' (glob)"
fi


echo ""
echo "🔹 REGEX (com =~) - mais poderoso"
echo "─────────────────────────────────────────────────────────────────"

url="https://exemplo.com"

echo "URL: $url"

if [[ "$url" =~ ^https:// ]]; then
  echo "  ✓ Começa com https:// (regex)"
fi

if [[ "$url" =~ \.com$ ]]; then
  echo "  ✓ Termina com .com (regex)"
fi

if [[ "$url" =~ ^https://[a-zA-Z0-9.-]+ ]]; then
  echo "  ✓ Domínio válido (regex)"
fi

if [[ ! "$url" =~ ^http:// ]]; then
  echo "  ✓ Não começa com http:// (negação com regex)"
fi


###############################################################################
# 📊 PARTE 4: TABELA DE REFERÊNCIA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA - REGEX"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌──────────────┬───────────┬──────────────────────┬─────────────────────┐
│ Elemento     │ Símbolo   │ Significado          │ Exemplo             │
├──────────────┼───────────┼──────────────────────┼─────────────────────┤
│ Início       │ ^         │ Começar com          │ ^hello              │
│ Fim          │ $         │ Terminar com         │ goodbye$            │
│ Qualquer 1   │ .         │ Um caractere qual.   │ t.st                │
│ Zero ou mais │ *         │ Repetir 0+ vezes     │ ab*c (ac, abc, ...) │
│ Uma ou mais  │ +         │ Repetir 1+ vezes     │ ab+c (abc, abbc,..) │
│ Zero ou um   │ ?         │ Opcional             │ ab?c (ac, abc)      │
│ Intervalo    │ {n,m}     │ Entre n e m vezes    │ a{2,4}              │
│ Classe       │ []        │ Um char da lista     │ [abc]               │
│ Intervalo    │ [a-z]     │ Intervalo de chars   │ [0-9]               │
│ Negação      │ [^abc]    │ Não a, b, ou c       │ [^0-9]              │
│ Grupo        │ ()        │ Captura              │ (abc)               │
│ OU           │ |         │ Alternativa          │ (cat|dog)           │
│ Escape       │ \\        │ Literal especial     │ \\. (ponto literal) │
│                          │                      │                     │
│ Dígito       │ [0-9]     │ Qualquer dígito      │ [0-9]{2,3}          │
│ Letra        │ [a-z]     │ Letra minúscula      │ [a-z]+              │
│ Letra        │ [A-Z]     │ Letra maiúscula      │ [A-Z]{1,3}          │
│ Alfanumérico │ [a-zA-Z]  │ Letra qual           │ [a-zA-Z0-9_]+       │
│ Espaço       │ \\s       │ Espaço em branco     │ \\s+                │
│ Não espaço   │ \\S       │ Não espaço           │ \\S+                │
│ Palavra      │ \\w       │ Letra/número/_       │ \\w+                │
│ Não palavra  │ \\W       │ Não \\w              │ \\W+                │
│                          │                      │                     │
└──────────────┴───────────┴──────────────────────┴─────────────────────┘

TABELA

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
