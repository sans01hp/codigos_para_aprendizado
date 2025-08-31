#!/bin/bash

cat <<'EOF'

===============================
| Guia Básico de Expressões Regulares (Regex)
===============================

Regex é um padrão usado para procurar ou validar textos.

-------------------------------
| Símbolos Básicos e Significados
-------------------------------

.       -> Corresponde a QUALQUER caractere, exceto nova linha
^       -> Início da string
$       -> Fim da string
[]      -> Conjunto de caracteres (ex: [abc] casa com 'a', 'b' ou 'c')
[^]     -> Negação do conjunto (ex: [^0-9] casa com qualquer caractere que NÃO seja número)
\       -> Escape do caractere especial (ex: \. para ponto literal)
|       -> OU lógico entre padrões (ex: cat|dog casa "cat" ou "dog")
()      -> Agrupamento para aplicar operadores ou capturar grupo

-------------------------------
| Quantificadores (Repetições)
-------------------------------

*       -> Zero ou mais vezes (ex: a* casa "", "a", "aa", "aaa", ...)
+       -> Uma ou mais vezes (ex: a+ casa "a", "aa", "aaa", ...)
?       -> Zero ou uma vez (ex: colou?r casa "color" ou "colour")
{n}     -> Exatamente n vezes (ex: a{3} casa "aaa")
{n,}    -> Pelo menos n vezes (ex: a{2,} casa "aa", "aaa", ...)
{n,m}   -> Entre n e m vezes (ex: a{1,3} casa "a", "aa", ou "aaa")

-------------------------------
| Exemplos Práticos
-------------------------------

1) Validar número de telefone simples (ex: 123-4567):

^[0-9]{3}-[0-9]{4}$

2) Validar email simplificado:

^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$

3) Procurar "cat" ou "dog":

cat|dog

4) Validar URL https terminando em .com (exemplo do seu teste anterior):

^https://[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+\.com$

-------------------------------
| Uso do Escape '\'
-------------------------------

- Caracteres especiais como . ^ $ [ ] ( ) | ? * + { } precisam ser "escapados" com \ se quiser usá-los literalmente.
- Exemplo: O ponto '.' casa com qualquer caractere, para casar um ponto real, use '\.'

Exemplo:

- Regex: hello.world
  - Casaria "hello world", "helloXworld", "hello1world" (qualquer caractere entre hello e world)
- Regex: hello\.world
  - Casaria apenas "hello.world" literalmente.

-------------------------------
| Exemplo de código bash usando regex
-------------------------------

EOF

# Exemplo prático dentro do script:

read -p "Digite uma string para validar URL https terminando em .com: " url

if [[ "$url" =~ ^https://[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+\.com$ ]]; then
  echo "✅ URL válida!"
else
  echo "❌ URL inválida!"
fi

cat <<'EOF'

===============================
| Fim do guia básico de regex
===============================

Dúvidas? Pergunte sempre!
EOF
