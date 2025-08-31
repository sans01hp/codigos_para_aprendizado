#!/bin/bash

# Exemplos de uso de expressões regulares com [[ ... =~ ... ]]

texto="abc123"
num="4567"
email="user@example.com"
telefone="(11) 91234-5678"

echo "Verificando se '$texto' contém números:"
if [[ $texto =~ [0-9]+ ]]; then
  echo "✅ '$texto' contém números"
else
  echo "❌ '$texto' não contém números"
fi

echo

echo "Verificando se '$num' é um número inteiro:"
if [[ $num =~ ^[0-9]+$ ]]; then
  echo "✅ '$num' é um número inteiro"
else
  echo "❌ '$num' não é um número inteiro"
fi

echo

echo "Verificando se '$email' parece um email válido:"
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  echo "✅ '$email' parece um email válido"
else
  echo "❌ '$email' não parece um email válido"
fi

echo

echo "Verificando se '$telefone' está no formato (xx) xxxxx-xxxx:"
if [[ $telefone =~ ^\([0-9]{2}\)\ [0-9]{4,5}-[0-9]{4}$ ]]; then
  echo "✅ '$telefone' tem formato de telefone válido"
else
  echo "❌ '$telefone' não tem formato válido"
fi

echo

# Exemplo com captura de grupos
texto2="abc123def"
echo "Capturando grupos na string '$texto2':"
if [[ $texto2 =~ ([a-z]+)([0-9]+)([a-z]+) ]]; then
  echo "Parte 1 (letras): ${BASH_REMATCH[1]}"
  echo "Parte 2 (números): ${BASH_REMATCH[2]}"
  echo "Parte 3 (letras): ${BASH_REMATCH[3]}"
else
  echo "❌ Não casou o padrão."
fi
