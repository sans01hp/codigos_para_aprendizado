#!/bin/bash

texto="abc123"
num="4567"
email="user@example.com"
telefone="(11) 91234-5678"

# Verificar se texto contém números
if [[ $texto =~ [0-9]+ ]]; then
  echo "'$texto' contém números"
fi

# Verificar se num é só dígitos (número inteiro)
if [[ $num =~ ^[0-9]+$ ]]; then
  echo "'$num' é um número inteiro"
fi

# Verificar se email tem formato básico (com @ e .)
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  echo "'$email' parece um email válido"
else
  echo "'$email' NÃO parece um email válido"
fi

# Verificar se telefone está no formato (xx) xxxxx-xxxx
if [[ $telefone =~ ^\([0-9]{2}\)\ [0-9]{4,5}-[0-9]{4}$ ]]; then
  echo "'$telefone' tem formato de telefone válido"
else
  echo "'$telefone' NÃO tem formato válido"
fi
