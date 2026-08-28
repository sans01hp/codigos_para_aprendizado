#!/bin/bash

################################################################################
#                   EOF E HERE DOCUMENTS - GUIA COMPLETO
#
# Este arquivo consolida exemplos sobre:
# - Sintaxe básica de HERE DOCUMENTS (cat << EOF)
# - Variáveis dentro de EOF (interpolação)
# - EOF com aspas (texto literal)
# - Redirecionamento de saída (> arquivo)
# - Leitura linha por linha (while read)
# - Armazenar em variáveis
# - Agrupamento de comandos { }
# - Case statement com patterns
################################################################################


###############################################################################
# 📘 PARTE 1: CONCEITOS FUNDAMENTAIS
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║              HERE DOCUMENTS (EOF) - CONCEITOS                 ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'CONCEITOS'

═══════════════════════════════════════════════════════════════════
O QUE É EOF (HERE DOCUMENT)?
═══════════════════════════════════════════════════════════════════

EOF (End Of File) é um delimitador de texto multi-linha em Bash.
Permite criar blocos de texto sem usar múltiplos echo ou escape.

Sintaxe básica:
───────────────
cat <<EOF
Texto aqui
Pode ter várias linhas
EOF

═══════════════════════════════════════════════════════════════════
VARIÁVEIS EM EOF - COM OU SEM ASPAS?
═══════════════════════════════════════════════════════════════════

1. SEM ASPAS - Variáveis são INTERPOLADAS (expandidas):
   cat <<EOF
   A variável \$VAR tem valor: $VAR
   EOF

2. COM ASPAS - Texto é LITERAL (variáveis não expandem):
   cat << "EOF"
   A variável \$VAR tem valor: $VAR
   EOF

Exemplo prático:
   NAME="Alice"
   
   cat <<EOF
   Olá, $NAME      # Imprime: Olá, Alice
   EOF
   
   cat << "EOF"
   Olá, $NAME      # Imprime: Olá, $NAME
   EOF

═══════════════════════════════════════════════════════════════════
REDIRECIONAMENTO - SAÍDA EM ARQUIVO
═══════════════════════════════════════════════════════════════════

Usar > para gravar em arquivo:
   cat <<EOF > arquivo.txt
   Conteúdo será gravado em arquivo.txt
   EOF

Usar >> para ACRESCENTAR:
   cat <<EOF >> arquivo.txt
   Conteúdo será acrescentado
   EOF

═══════════════════════════════════════════════════════════════════
LEITURA LINHA A LINHA
═══════════════════════════════════════════════════════════════════

Ler cada linha de um heredoc:
   while IFS= read -r linha; do
       echo "Linha: $linha"
   done <<EOF
   Primeira linha
   Segunda linha
   Terceira linha
   EOF

═══════════════════════════════════════════════════════════════════
ARMAZENAR EM VARIÁVEL
═══════════════════════════════════════════════════════════════════

Use read -d '' para armazenar todo o conteúdo:
   read -r -d '' variavel <<EOF
   Texto com
   múltiplas linhas
   armazenado em \$variavel
   EOF

═══════════════════════════════════════════════════════════════════
AGRUPAMENTO DE COMANDOS { }
═══════════════════════════════════════════════════════════════════

Use { } para agrupar múltiplos comandos e redirecionar a saída:
   {
       echo "Linha 1"
       echo "Linha 2"
       cat < arquivo.txt
   } > saida.txt

Útil para redirecionar múltiplos comandos de uma vez.

═══════════════════════════════════════════════════════════════════
CASE STATEMENT COM PATTERNS
═══════════════════════════════════════════════════════════════════

Case permite comparar contra padrões (globs, não regex):
   case "$var" in
       https://*)
           echo "URL começa com https"
           ;;
       *.com)
           echo "Domínio .com"
           ;;
       *)
           echo "Padrão não casou"
           ;;
   esac

Padrões comuns:
   https://*     → começa com "https://"
   *.com         → termina com ".com"
   [a-z]*        → começa com minúscula
   ?(padrão)     → padrão é opcional

✅ DICA: Use regex DENTRO dos blocos case com [[ ]] se precisar

CONCEITOS


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - HERE DOCUMENTS"
echo "═══════════════════════════════════════════════════════════════════"

# --- EXEMPLO 1: Texto simples na tela ---
echo ""
echo "🔹 EXEMPLO 1: Imprimir texto multi-linha"
echo "─────────────────────────────────────────────────────────────────"

cat <<EOF
Este é um bloco de texto multi-linha
usando HERE DOCUMENT (cat <<EOF).
Não preciso usar múltiplos echo.
Pode ter várias linhas facilmente.
EOF


# --- EXEMPLO 2: Criando arquivo com EOF ---
echo ""
echo "🔹 EXEMPLO 2: Criar arquivo com EOF"
echo "─────────────────────────────────────────────────────────────────"

cat <<EOF > /tmp/mensagem_criada.txt
Arquivo criado em: $(date)
Usando HERE DOCUMENT
Conteúdo multi-linha é fácil!
EOF

echo "✓ Arquivo criado: /tmp/mensagem_criada.txt"
echo "Conteúdo:"
cat /tmp/mensagem_criada.txt


# --- EXEMPLO 3: Variáveis DENTRO de EOF (interpolação) ---
echo ""
echo "🔹 EXEMPLO 3: Interpolação de variáveis"
echo "─────────────────────────────────────────────────────────────────"

USUARIO="Carlos"
DATA_ATUAL=$(date +%d/%m/%Y)

cat <<EOF
Bem-vindo, $USUARIO!
Data de hoje: $DATA_ATUAL
Resultado de cálculo: $((2 + 2))
Seu HOME é: $HOME
EOF


# --- EXEMPLO 4: EOF com aspas (LITERAL) ---
echo ""
echo "🔹 EXEMPLO 4: Texto LITERAL com aspas"
echo "─────────────────────────────────────────────────────────────────"

VARIAVEL="NÃO VAI SER EXPANDIDA"

cat << "EOF"
Dentro de aspas, as variáveis não são expandidas:
$VARIAVEL continua como \$VARIAVEL
Comandos não executam: $(echo teste)
Símbolos especiais aparecem literalmente: \n \t $(comando)
EOF


# --- EXEMPLO 5: Leitura linha a linha ---
echo ""
echo "🔹 EXEMPLO 5: Ler cada linha do heredoc"
echo "─────────────────────────────────────────────────────────────────"

echo "Processando linhas:"
while IFS= read -r linha; do
    echo "  > $linha"
done <<DADOS
Primeira linha
Segunda linha
Terceira linha
DADOS


# --- EXEMPLO 6: Armazenar conteúdo em variável ---
echo ""
echo "🔹 EXEMPLO 6: Armazenar heredoc em variável"
echo "─────────────────────────────────────────────────────────────────"

read -r -d '' CONTEUDO_MULTILINHAS <<EOF
Isso é uma variável
com múltiplas linhas
armazenada de uma vez.
EOF

echo "Conteúdo da variável:"
echo "$CONTEUDO_MULTILINHAS"


# --- EXEMPLO 7: Agrupamento de comandos ---
echo ""
echo "🔹 EXEMPLO 7: Agrupar múltiplos comandos"
echo "─────────────────────────────────────────────────────────────────"

cat <<EOF > /tmp/relatorio.txt
=== RELATÓRIO ===
Arquivos no /tmp:
$(ls -la /tmp | head -5)

Informações do usuário: $USER
Data: $(date)
EOF

echo "✓ Relatório criado: /tmp/relatorio.txt"
echo "Primeiras linhas:"
head -8 /tmp/relatorio.txt


# --- EXEMPLO 8: Case statement com patterns ---
echo ""
echo "🔹 EXEMPLO 8: Case com padrões (globbing)"
echo "─────────────────────────────────────────────────────────────────"

testar_url() {
    local url="$1"
    
    case "$url" in
        https://*)
            echo "  ✓ URL segura (HTTPS)"
            ;;
        http://*)
            echo "  ⚠ URL insegura (HTTP)"
            ;;
        *.com)
            echo "  ✓ Domínio comercial (.com)"
            ;;
        *.com.br)
            echo "  ✓ Domínio Brasil (.com.br)"
            ;;
        *)
            echo "  ✗ Padrão não reconhecido"
            ;;
    esac
}

echo "Testando padrões de URL:"
testar_url "https://google.com"
testar_url "http://example.com.br"
testar_url "ftp://files.org"


# --- EXEMPLO 9: Heredoc para criar scripts ---
echo ""
echo "🔹 EXEMPLO 9: Usar heredoc para criar outro script"
echo "─────────────────────────────────────────────────────────────────"

cat > /tmp/script_criado.sh <<'SCRIPT'
#!/bin/bash
echo "Este script foi criado usando heredoc!"
echo "Criado em: $(date)"
echo "Usuário: $USER"
SCRIPT

chmod +x /tmp/script_criado.sh
echo "✓ Script criado: /tmp/script_criado.sh"
echo "Executando:"
/tmp/script_criado.sh


# --- EXEMPLO 10: Heredoc com função SQL (simulado) ---
echo ""
echo "🔹 EXEMPLO 10: Heredoc para blocos complexos"
echo "─────────────────────────────────────────────────────────────────"

executar_comando_complexo() {
    local entrada="$1"
    
    # Simular execução de comando complexo
    cat <<EOF
Entrada recebida: $entrada
Processando...
---
Simulação de SQL SELECT:
  SELECT * FROM usuarios WHERE ativo = 1
  
Resultado: 3 registros retornados
---
Fim do processamento
EOF
}

executar_comando_complexo "teste123"


###############################################################################
# 🔄 PARTE 3: CASOS DE USO AVANÇADOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "CASOS DE USO AVANÇADOS"
echo "═══════════════════════════════════════════════════════════════════"

# --- Criar arquivo de configuração ---
echo ""
echo "🔹 Criar arquivo de configuração"

cat > /tmp/config.env <<EOF
# Configuração da aplicação
APP_NAME="MeuApp"
DB_HOST="localhost"
DB_PORT=5432
DEBUG=true
CREATED=$(date)
EOF

echo "✓ Arquivo de configuração criado:"
cat /tmp/config.env


# --- HTML com heredoc ---
echo ""
echo "🔹 Gerar HTML com heredoc"

cat > /tmp/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Página Gerada</title>
</head>
<body>
    <h1>Olá!</h1>
    <p>Esta página foi gerada com bash heredoc.</p>
</body>
</html>
HTML

echo "✓ Página HTML criada: /tmp/index.html"


###############################################################################
# 📊 PARTE 4: TABELA DE REFERÊNCIA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌─────────────────────────────┬─────────────────┬──────────────────────┐
│ Uso                         │ Sintaxe          │ Exemplo              │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Imprimir na tela            │ cat <<EOF...EOF │ cat <<EOF            │
│                             │                 │ Texto                │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Gravar em arquivo           │ cat <<EOF >file │ cat <<EOF > file.txt │
│                             │ ...EOF          │ Conteúdo             │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Acrescentar em arquivo      │ cat <<EOF >>    │ cat <<EOF >> file    │
│                             │ file...EOF      │ Mais conteúdo        │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Com interpolação de var     │ cat <<EOF       │ cat <<EOF            │
│                             │ ...EOF          │ Valor: $VAR          │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Texto literal (sem expandir)│ cat << "EOF"    │ cat << "EOF"         │
│                             │ ...EOF          │ Literal: $VAR        │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Ler linha por linha         │ while read <<EOF│ while IFS= read -r   │
│                             │ ...EOF          │ line; do...done <<   │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Armazenar em variável       │ read -d '' var  │ read -r -d '' var    │
│                             │ <<EOF...EOF     │ <<EOF                │
│                             │                 │ Multilinhas          │
│                             │                 │ EOF                  │
├─────────────────────────────┼─────────────────┼──────────────────────┤
│ Agrupar comandos            │ { cmd1; cmd2 }  │ { echo "a"           │
│                             │ > file          │ echo "b" } > file    │
└─────────────────────────────┴─────────────────┴──────────────────────┘

TABELA

# Limpeza
rm -f /tmp/mensagem_criada.txt /tmp/relatorio.txt /tmp/script_criado.sh /tmp/config.env /tmp/index.html

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
