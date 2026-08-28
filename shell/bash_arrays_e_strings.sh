#!/bin/bash

################################################################################
#                   ARRAYS E MANIPULAÇÃO DE STRINGS - GUIA COMPLETO
#
# Este arquivo consolida exemplos sobre:
# - Arrays simples vs arrays associativos
# - Operações com arrays (append, remove, loop)
# - Manipulação de strings (split, trim, replace)
# - Printf para formatação de tabelas
# - Validação com regex antes de adicionar em arrays
################################################################################


###############################################################################
# 📘 PARTE 1: CONCEITOS FUNDAMENTAIS
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║           ARRAYS E STRINGS - CONCEITOS                        ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'CONCEITOS'

═══════════════════════════════════════════════════════════════════
TIPOS DE ARRAYS
═══════════════════════════════════════════════════════════════════

1. ARRAYS SIMPLES (INDEXADOS)
   Declaração:
      arr=(elemento1 elemento2 elemento3)
   Acesso:
      ${arr[0]}      → primeiro elemento
      ${arr[@]}      → todos os elementos
      ${#arr[@]}     → número de elementos
   Adicionar:
      arr+=(novo)    → adiciona ao final
   Remover:
      unset arr[2]   → remove índice 2

2. ARRAYS ASSOCIATIVOS (DICCIONÁRIOS)
   Declaração:
      declare -A hash
   Acesso:
      hash[chave]="valor"
      ${hash["chave"]}
   Iteração:
      for chave in "${!hash[@]}"; do
          echo "${hash[$chave]}"
      done

═══════════════════════════════════════════════════════════════════
OPERAÇÕES COM STRINGS
═══════════════════════════════════════════════════════════════════

TAMANHO:
   ${#string}         → Comprimento da string

SUBSTRING:
   ${string:posição}     → Do início até o final
   ${string:0:5}         → Primeiros 5 caracteres
   ${string: -3}         → Últimos 3 caracteres

SUBSTITUIÇÃO:
   ${string/old/new}     → Substituir primeira ocorrência
   ${string//old/new}    → Substituir todas ocorrências
   ${string#prefix}      → Remover prefixo
   ${string%suffix}      → Remover sufixo

MAIÚSCULAS/MINÚSCULAS:
   ${string^^}        → Converter para maiúsculas (Bash 4+)
   ${string,,}        → Converter para minúsculas (Bash 4+)

SPLIT (dividir string):
   read -ra arr <<< "$string"   → Dividir por espaço
   IFS=',' read -ra arr <<< "$string"  → Dividir por vírgula

═══════════════════════════════════════════════════════════════════
PRINTF PARA FORMATAÇÃO
═══════════════════════════════════════════════════════════════════

Flags de formato:
   %-20s   → String, 20 chars, alinhado à esquerda
   %20s    → String, 20 chars, alinhado à direita
   %10.2f  → Float, 10 chars total, 2 decimais
   %5d     → Inteiro, 5 caracteres

Exemplo - Tabela:
   printf "%-15s %10.2f\n" "Produto" "Preço"
   printf "%-15s %10.2f\n" "Maçã" "2.50"

═══════════════════════════════════════════════════════════════════
VALIDAÇÃO ANTES DE ADICIONAR
═══════════════════════════════════════════════════════════════════

Sempre validar dados com regex antes de adicionar a um array:
   if [[ "$url" =~ ^https:// ]]; then
       urls+=("$url")
   fi

Evita dados inválidos no array desde o início.

CONCEITOS


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - ARRAYS E STRINGS"
echo "═══════════════════════════════════════════════════════════════════"

# --- EXEMPLO 1: Array simples ---
echo ""
echo "🔹 EXEMPLO 1: Array simples (indexado)"
echo "─────────────────────────────────────────────────────────────────"

# Declarar array
frutas=("maçã" "banana" "laranja" "uva")

echo "Array completo: ${frutas[@]}"
echo "Número de elementos: ${#frutas[@]}"
echo ""
echo "Acessando elementos:"
echo "  Primeiro: ${frutas[0]}"
echo "  Segundo: ${frutas[1]}"
echo "  Último: ${frutas[-1]}"  # Bash 4.3+

echo ""
echo "Iterando sobre o array:"
for (( i=0; i<${#frutas[@]}; i++ )); do
    echo "  [$i]: ${frutas[$i]}"
done


# --- EXEMPLO 2: Adicionar e remover de array ---
echo ""
echo "🔹 EXEMPLO 2: Adicionar e remover elementos"
echo "─────────────────────────────────────────────────────────────────"

cores=("vermelho" "azul")
echo "Array inicial: ${cores[@]}"

# Adicionar
cores+=("verde")
cores+=("amarelo")
echo "Após adicionar: ${cores[@]}"

# Remover
unset cores[1]  # Remove índice 1
echo "Após remover índice 1: ${cores[@]}"


# --- EXEMPLO 3: Array associativo (dicionário) ---
echo ""
echo "🔹 EXEMPLO 3: Array associativo"
echo "─────────────────────────────────────────────────────────────────"

# Declarar array associativo
declare -A precos
precos["maçã"]=2.50
precos["banana"]=1.50
precos["laranja"]=3.00

echo "Preços:"
for fruta in "${!precos[@]}"; do
    echo "  $fruta: \$${precos[$fruta]}"
done


# --- EXEMPLO 4: URLs com validação ---
echo ""
echo "🔹 EXEMPLO 4: Array de URLs com validação de HTTPS"
echo "─────────────────────────────────────────────────────────────────"

declare -A urls
urls["google"]="www.google.com"
urls["github"]="github.com"
urls["example"]="example.com"

echo "URLs originais: ${urls[@]}"
echo ""
echo "Adicionando https:// se necessário:"

for site in "${!urls[@]}"; do
    url="${urls[$site]}"
    
    # Validar e corrigir
    if [[ ! "$url" =~ ^https?:// ]]; then
        urls["$site"]="https://$url"
        echo "  ✓ $site → ${urls[$site]}"
    fi
done


# --- EXEMPLO 5: Manipulação de strings ---
echo ""
echo "🔹 EXEMPLO 5: Manipulação de strings"
echo "─────────────────────────────────────────────────────────────────"

texto="  Olá Mundo  "

echo "String original: [$texto]"
echo "Comprimento: ${#texto}"

# Remover espaços (trim)
texto_trimmed="${texto## }"
texto_trimmed="${texto_trimmed%% }"
echo "Após trim: [$texto_trimmed]"

# Converter para maiúsculas
echo "Maiúsculas: ${texto_trimmed^^}"

# Converter para minúsculas
echo "Minúsculas: ${texto_trimmed,,}"

# Substituir palavra
echo "Substituir 'Mundo' por 'Bash': ${texto_trimmed/Mundo/Bash}"

# Remover prefixo
echo "Remove 'Olá ': ${texto_trimmed#Olá }"

# Remover sufixo
echo "Remove ' Mundo': ${texto_trimmed% Mundo}"


# --- EXEMPLO 6: Dividir string em array ---
echo ""
echo "🔹 EXEMPLO 6: Dividir string em array"
echo "─────────────────────────────────────────────────────────────────"

csv="João,25,São Paulo"
echo "CSV: $csv"

# Dividir por vírgula
IFS=',' read -ra dados <<< "$csv"

echo "Array após split:"
for (( i=0; i<${#dados[@]}; i++ )); do
    echo "  [$i]: ${dados[$i]}"
done


# --- EXEMPLO 7: Printf para formatação de tabela ---
echo ""
echo "🔹 EXEMPLO 7: Tabela formatada com printf"
echo "─────────────────────────────────────────────────────────────────"

declare -A precotabela
precotabela["Maçã"]=2.50
precotabela["Banana"]=1.50
precotabela["Laranja"]=3.00
precotabela["Uva"]=4.00

# Cabeçalho
printf "%-20s %10s\n" "Produto" "Preço (R\$)"
printf "%-20s %10s\n" "─────────────────" "─────────"

# Dados
for produto in "${!precotabela[@]}"; do
    printf "%-20s %10.2f\n" "$produto" "${precotabela[$produto]}"
done


# --- EXEMPLO 8: Array com objeto simulado ---
echo ""
echo "🔹 EXEMPLO 8: Array de 'objetos' (usando múltiplos arrays)"
echo "─────────────────────────────────────────────────────────────────"

# Simulando um "banco de dados" com múltiplos arrays
declare -a nomes=("Alice" "Bob" "Carlos")
declare -a idades=(25 30 28)
declare -a cidades=("São Paulo" "Rio" "Belo Horizonte")

echo "Pessoas registradas:"
for (( i=0; i<${#nomes[@]}; i++ )); do
    printf "  %-15s %3d anos - %s\n" "${nomes[$i]}" "${idades[$i]}" "${cidades[$i]}"
done


# --- EXEMPLO 9: Verificar se elemento existe no array ---
echo ""
echo "🔹 EXEMPLO 9: Verificar existência em array"
echo "─────────────────────────────────────────────────────────────────"

lista_permitida=("admin" "user" "guest")

verificar_usuario() {
    local usuario="$1"
    
    for u in "${lista_permitida[@]}"; do
        if [[ "$u" == "$usuario" ]]; then
            echo "  ✓ $usuario está na lista"
            return 0
        fi
    done
    
    echo "  ✗ $usuario NÃO está na lista"
    return 1
}

echo "Verificando usuários:"
verificar_usuario "admin"
verificar_usuario "visitor"
verificar_usuario "guest"


# --- EXEMPLO 10: Operações matemáticas em array ---
echo ""
echo "🔹 EXEMPLO 10: Calcular soma e média"
echo "─────────────────────────────────────────────────────────────────"

numeros=(10 20 30 40 50)

soma=0
for num in "${numeros[@]}"; do
    ((soma += num))
done

media=$((soma / ${#numeros[@]}))

echo "Array: ${numeros[@]}"
echo "Soma: $soma"
echo "Média: $media"


###############################################################################
# 🔄 PARTE 3: CASOS DE USO AVANÇADOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "CASOS DE USO AVANÇADOS"
echo "═══════════════════════════════════════════════════════════════════"

# --- Remover duplicatas de array ---
echo ""
echo "🔹 Remover duplicatas de array"

arr_com_duplicatas=("a" "b" "a" "c" "b" "d")
echo "Array com duplicatas: ${arr_com_duplicatas[@]}"

# Usando declare -A para remover duplicatas
declare -A unicos
for item in "${arr_com_duplicatas[@]}"; do
    unicos["$item"]=1
done

echo "Sem duplicatas: ${!unicos[@]}"


# --- Ordenar array (usando sort) ---
echo ""
echo "🔹 Ordenar array alfabeticamente"

arr_desordenado=("zebra" "apple" "mango" "banana")
echo "Antes: ${arr_desordenado[@]}"

# Converter para string, sort, converter de volta para array
IFS=$'\n' arr_ordenado=($(sort <<<"${arr_desordenado[*]}"))
echo "Depois: ${arr_ordenado[@]}"


# --- Encontrar índice de elemento ---
echo ""
echo "🔹 Encontrar índice de um elemento"

buscar_indice() {
    local procurado="$1"
    shift
    local -n arr=$1
    
    for i in "${!arr[@]}"; do
        if [[ "${arr[$i]}" == "$procurado" ]]; then
            echo "Encontrado no índice $i"
            return 0
        fi
    done
    
    echo "Não encontrado"
    return 1
}

palavras=("gato" "cachorro" "pássaro" "peixe")
buscar_indice "pássaro" palavras


###############################################################################
# 📊 PARTE 4: TABELA DE REFERÊNCIA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌──────────────────────────────┬──────────────────┬──────────────────────┐
│ Operação                     │ Sintaxe           │ Exemplo              │
├──────────────────────────────┼──────────────────┼──────────────────────┤
│ Declarar array               │ arr=(...)         │ arr=("a" "b" "c")    │
│ Acessar elemento             │ ${arr[n]}         │ ${arr[0]}            │
│ Todos os elementos           │ ${arr[@]}         │ echo ${arr[@]}       │
│ Número de elementos          │ ${#arr[@]}        │ ${#arr[@]}           │
│ Adicionar elemento           │ arr+=(novo)       │ arr+=("d")           │
│ Remover elemento             │ unset arr[n]      │ unset arr[0]         │
│                              │                   │                      │
│ Declarar array assoc         │ declare -A hash   │ declare -A precos    │
│ Acessar valor                │ ${hash[key]}      │ ${hash["nome"]}      │
│ Todas as chaves              │ ${!hash[@]}       │ for k in ${!hash[@]} │
│ Loop por valor               │ for v in ${arr[@]}│ for v in "${arr[@]}" │
│                              │                   │                      │
│ Comprimento string           │ ${#string}        │ ${#texto}            │
│ Substring                    │ ${string:pos:len} │ ${string:0:5}        │
│ Remover prefixo              │ ${string#prefix}  │ ${string#/usr}       │
│ Remover sufixo               │ ${string%suffix}  │ ${string%.txt}       │
│ Substituir (primeira)        │ ${string/old/new} │ ${str/foo/bar}       │
│ Substituir (todas)           │ ${string//o/new}  │ ${str//o/0}          │
│ Maiúsculas                   │ ${string^^}       │ ${text^^}            │
│ Minúsculas                   │ ${string,,}       │ ${text,,}            │
│                              │                   │                      │
│ Split em array               │ read -ra arr      │ IFS=, read -ra arr   │
│ Printf alinhado esq          │ %-20s             │ printf "%-20s" $var  │
│ Printf alinhado dir          │ %20s              │ printf "%20s" $var   │
│ Printf float 2 decimais      │ %10.2f            │ printf "%10.2f" 3.14 │
│                              │                   │                      │
└──────────────────────────────┴──────────────────┴──────────────────────┘

TABELA

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
