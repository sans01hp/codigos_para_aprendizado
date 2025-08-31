#!/bin/bash
# ===========================================
# SCRIPT COMPLETO - EXEMPLOS PRÁTICOS
# 1️⃣ POSICIONAIS + VARIÁVEIS
# 2️⃣ HERE DOCUMENT (EOF)
# 3️⃣ IFS
# ===========================================


# ===========================================
# 1️⃣ POSICIONAIS + VARIÁVEIS
# -------------------------------------------
echo "=== BLOCO 1: POSICIONAIS E VARIÁVEIS ==="

# Usa argumentos passados na linha de comando
# Exemplo de chamada: ./meuscript.sh Alice 25

# $1 = primeiro argumento
# $2 = segundo argumento

nome="$1"
idade="$2"
cidade="São Paulo"  # Variável normal

echo "Primeiro argumento (nome): $nome"
echo "Segundo argumento (idade): $idade"
echo "Cidade fixa: $cidade"

echo "Quantidade de argumentos passados: $#"
echo "Todos os argumentos: $@"

echo ""  # Linha em branco


# ===========================================
# 2️⃣ HERE DOCUMENT (EOF)
# -------------------------------------------
echo "=== BLOCO 2: HERE DOCUMENT (EOF) ==="

# Cria um arquivo de texto com várias linhas
# usando <<EOF

cat <<EOF > mensagem.txt
Olá, este arquivo foi criado usando Here Document (EOF).
Você pode escrever várias linhas de texto
sem precisar de múltiplos echo.

Este texto foi salvo em mensagem.txt.
EOF

echo "Arquivo 'mensagem.txt' criado!"
echo "Conteúdo do arquivo:"
cat mensagem.txt

echo ""  # Linha em branco


# ===========================================
# 3️⃣ IFS (Internal Field Separator)
# -------------------------------------------
echo "=== BLOCO 3: IFS ==="

# Define uma string separada por vírgulas
frutas="maçã,banana,laranja"

# Define IFS como vírgula
IFS=','

# Usa read para separar em variáveis
read -r fruta1 fruta2 fruta3 <<< "$frutas"

echo "Fruta 1: $fruta1"
echo "Fruta 2: $fruta2"
echo "Fruta 3: $fruta3"

# Mostra o que acontece com IFS padrão
IFS=' '  # Reseta IFS para espaço/tab/nova linha

read -r uma duas tres <<< "$frutas"

echo "Usando IFS padrão:"
echo "uma: $uma"
echo "duas: $duas"
echo "tres: $tres"

echo "=== FIM DO SCRIPT ==="
