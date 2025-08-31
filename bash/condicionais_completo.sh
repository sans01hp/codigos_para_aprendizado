#!/bin/bash

# =====================================================
# Script Bash Completo - Testes, Funções, Loops
# =====================================================

# Exemplo de variável exportada:
# export NOME="SeuNome"

# Função para verificar se uma variável está definida
verifica_variavel() {
  local VAR="$1"  # A variável só existe dentro da função

  if [ -z "$VAR" ]; then
    echo "⚠️  Variável está vazia ou não definida."
  else
    echo "✅ Variável definida: $VAR"
  fi
}

# Função que usa export para criar variável de ambiente
cria_variavel_global() {
  export NOVA_VARIAVEL="Eu sou global!"
  echo "🔑 Variável NOVA_VARIAVEL criada com export."
}

# Função para mostrar contagem com loop for
contagem_for() {
  echo "📚 Contagem de 1 a 5 usando for:"
  for i in {1..5}; do
    echo " - Número: $i"
  done
}

# Função para mostrar loop while
contagem_while() {
  echo "⏳ Contagem regressiva usando while:"
  local contador=5
  while [ "$contador" -gt 0 ]; do
    echo " - $contador"
    contador=$((contador - 1))
  done
}

# =====================================================
# Uso real das funções
# =====================================================

echo "======================================="
echo "1️⃣  Testando variável NOME"
echo "======================================="
verifica_variavel "$NOME"

echo ""
echo "======================================="
echo "2️⃣  Criando variável global com export"
echo "======================================="
cria_variavel_global

echo ""
echo "======================================="
echo "3️⃣  Testando variável global no script"
echo "======================================="
# Essa variável existe porque foi exportada pela função
echo "🔍 NOVA_VARIAVEL = $NOVA_VARIAVEL"

echo ""
echo "======================================="
echo "4️⃣  Usando loop for"
echo "======================================="
contagem_for

echo ""
echo "======================================="
echo "5️⃣  Usando loop while"
echo "======================================="
contagem_while

echo ""
echo "======================================="
echo "6️⃣  Teste de condição com AND e OR"
echo "======================================="

VAR1="texto"
VAR2=""
NUM1=5
NUM2=10

if [ -n "$VAR1" ] && [ "$NUM1" -lt "$NUM2" ]; then
  echo "✅ VAR1 não está vazia E NUM1 é menor que NUM2"
fi

if [ -z "$VAR2" ] || [ "$NUM1" -eq 5 ]; then
  echo "✅ VAR2 está vazia OU NUM1 é 5"
fi

echo ""
echo "🏁 Script finalizado!"
