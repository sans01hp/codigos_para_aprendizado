#!/bin/bash

# ----------------------------------------
# EXEMPLO 1: Mostrar texto na tela com cat <<EOF
# ----------------------------------------
printf "\n--- Exemplo 1: cat com heredoc ---\n"
cat <<EOF
Esse texto está vindo de um bloco heredoc.
Não é executado como código, apenas exibido.
EOF

# ----------------------------------------
# EXEMPLO 2: Criar um arquivo com heredoc
# ----------------------------------------
printf "\n--- Exemplo 2: escrevendo num arquivo com <<EOF > arquivo ---\n"
cat <<EOF > exemplo.txt
Esse conteúdo está sendo salvo no arquivo exemplo.txt.
Cada linha é literal.
EOF
echo "Arquivo criado: exemplo.txt"

# ----------------------------------------
# EXEMPLO 3: Ler linha por linha de um heredoc (como um "arquivo virtual")
# ----------------------------------------
printf "\n--- Exemplo 3: while lendo cada linha do heredoc ---\n"
while IFS= read -r linha; do
    echo "Linha lida: $linha"
done <<TEXTO
linha A
linha B
linha C
TEXTO

# ----------------------------------------
# EXEMPLO 4: Ler conteúdo de um arquivo real com bloco de comandos
# ----------------------------------------
printf "\n--- Exemplo 4: bloco de leitura de um arquivo real ---\n"
{
  while IFS= read -r l; do
    echo ">> $l"
  done
} < exemplo.txt

# ----------------------------------------
# EXEMPLO 5: Heredoc armazenado numa única variável com read
# ----------------------------------------
printf "\n--- Exemplo 5: armazenando conteúdo em variável ---\n"
read -r -d '' variavel <<EOF
Texto com múltiplas linhas
armazenado numa única variável.
Funciona como se fosse um arquivo.
EOF

echo "Conteúdo da variável:"
echo "$variavel"

# Fim
