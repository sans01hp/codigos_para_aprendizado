#!/bin/bash

# Exemplo de uso de operadores condicionais no Bash
# Mostrando testes comuns para strings, números e arquivos

VAR1="texto"
VAR2=""
NUM1=5
NUM2=10
ARQUIVO="/etc/passwd"
PASTA="/tmp"

echo "Testes com strings"

# -z testa se a string está vazia (zero length)
if [ -z "$VAR2" ]; then
  echo "VAR2 está vazia"
fi

# -n testa se a string NÃO está vazia
if [ -n "$VAR1" ]; then
  echo "VAR1 não está vazia"
fi

# Igualdade de strings
if [ "$VAR1" = "texto" ]; then
  echo "VAR1 é igual a 'texto'"
fi

if [ "$VAR1" != "outra" ]; then
  echo "VAR1 não é 'outra'"
fi

echo ""
echo "Testes com números"

# Igualdade numérica
if [ "$NUM1" -eq "$NUM2" ]; then
  echo "NUM1 é igual a NUM2"
else
  echo "NUM1 não é igual a NUM2"
fi

# Maior que
if [ "$NUM1" -lt "$NUM2" ]; then
  echo "NUM1 é menor que NUM2"
fi

# Menor ou igual
if [ "$NUM1" -le 5 ]; then
  echo "NUM1 é menor ou igual a 5"
fi

echo ""
echo "Testes com arquivos"

# -e testa se arquivo ou diretório existe
if [ -e "$ARQUIVO" ]; then
  echo "O arquivo $ARQUIVO existe"
fi

# -f testa se é arquivo comum
if [ -f "$ARQUIVO" ]; then
  echo "$ARQUIVO é um arquivo regular"
fi

# -d testa se é diretório
if [ -d "$PASTA" ]; then
  echo "$PASTA é um diretório"
fi

# -r testa permissão de leitura
if [ -r "$ARQUIVO" ]; then
  echo "Você tem permissão para ler $ARQUIVO"
fi

# -w testa permissão de escrita
if [ -w "$PASTA" ]; then
  echo "Você tem permissão para escrever em $PASTA"
fi

# -x testa permissão de execução
if [ -x "$ARQUIVO" ]; then
  echo "Você pode executar $ARQUIVO"
else
  echo "Você NÃO pode executar $ARQUIVO"
fi

echo ""
echo "Testes lógicos"

# Teste AND (&&) — tudo precisa ser verdade
if [ "$NUM1" -lt "$NUM2" ] && [ "$VAR1" = "texto" ]; then
  echo "NUM1 é menor que NUM2 E VAR1 é 'texto'"
fi

# Teste OR (||) — pelo menos uma verdade
if [ "$NUM1" -gt "$NUM2" ] || [ -z "$VAR2" ]; then
  echo "NUM1 maior que NUM2 OU VAR2 vazia"
fi

