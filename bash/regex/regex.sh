#!/bin/bash

#===========================================================
# Script demonstrativo de comparações modernas no Bash/Zsh
# Usando [[ ]] para strings, glob, regex
# Usando (( )) para aritmética e comparações numéricas
#===========================================================

# 🔹 Entrada de usuário
read -p "Digite seu nome de usuário: " nome

# 🔸 Validação com [[ ]] usando regex (somente letras, números e _)
if [[ "$nome" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "✅ Nome de usuário válido"
else
    echo "❌ Nome inválido. Use apenas letras, números e underline (_)"
fi

# 🔹 Checar se nome é exatamente "admin"
if [[ "$nome" == "admin" ]]; then
    echo "🛠️  Olá, administrador"
fi

# 🔸 Verificar início com "https"
site="https://exemplo.com"
if [[ $site == https:* ]]; then
    echo "🌐 A URL começa com https"
fi

# 🔹 Entrada de idade
read -p "Digite sua idade: " idade

# 🔸 Comparação numérica usando (( ))
if (( idade >= 18 )); then
    echo "✅ Você é maior de idade"
else
    echo "❌ Acesso negado: menor de idade"
fi

# 🔸 Operações matemáticas
a=5
b=10

# Comparações com (( ))
if (( a < b )); then
    echo "📉 $a é menor que $b"
fi

# Incremento com (( ))
((a++))
echo "Novo valor de a: $a"

# Soma simples
((soma = a + b))
echo "Soma de a + b = $soma"

#===========================================================
# Tabela de referência rápida
#===========================================================
# [[ expr ]]      → Comparações de strings, glob, regex
# (( expr ))      → Operações e comparações numéricas
# [[ "$a" == "x" ]]   → Igualdade de strings
# [[ "$str" =~ ^[a-z]+$ ]] → Regex com alfabeto
# (( a > b ))     → Comparação numérica
# (( x++ ))       → Incremento
# (( soma = a + b )) → Atribuição e cálculo

#===========================================================
# Fim do script
#===========================================================
