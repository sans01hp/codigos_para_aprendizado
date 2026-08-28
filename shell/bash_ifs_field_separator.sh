#!/bin/bash

################################################################################
#                   IFS - FIELD SEPARATOR - GUIA COMPLETO
#
# Este arquivo consolida exemplos sobre:
# - O que é IFS (Internal Field Separator)
# - Valor padrão e como modificar
# - Uso com read para separar campos
# - Leitura de arquivos linha a linha
# - Tratamento de espaços e caracteres especiais
# - Problemas comuns e soluções
# - Exemplos práticos
################################################################################


###############################################################################
# 📘 PARTE 1: CONCEITOS FUNDAMENTAIS
###############################################################################

echo "
╔════════════════════════════════════════════════════════════════╗
║        IFS (Internal Field Separator) - CONCEITOS             ║
╚════════════════════════════════════════════════════════════════╝
"

cat << 'CONCEITOS'

═══════════════════════════════════════════════════════════════════
O QUE É IFS?
═══════════════════════════════════════════════════════════════════

IFS significa "Internal Field Separator" (Separador Interno de Campos).

É uma variável do shell que determina COMO uma string é dividida
em palavras/campos quando usada com comandos como read.

Valor padrão (espaço, tab, quebra de linha):
   IFS=' \t\n'

═══════════════════════════════════════════════════════════════════
COMO FUNCIONA
═══════════════════════════════════════════════════════════════════

Exemplo 1: IFS padrão (espaço)
─────────────────────────────
   string="maçã banana laranja"
   read fruta1 fruta2 fruta3 <<< "$string"
   
   Resultado:
   fruta1="maçã"
   fruta2="banana"
   fruta3="laranja"

Exemplo 2: IFS customizado (vírgula)
────────────────────────────────────
   string="maçã,banana,laranja"
   IFS=',' read fruta1 fruta2 fruta3 <<< "$string"
   
   Resultado:
   fruta1="maçã"
   fruta2="banana"
   fruta3="laranja"

═══════════════════════════════════════════════════════════════════
EXEMPLOS DE SEPARADORES CUSTOMIZADOS
═══════════════════════════════════════════════════════════════════

   IFS=','        → Separa por vírgula
   IFS=':'        → Separa por dois-pontos
   IFS='|'        → Separa por pipe
   IFS=';'        → Separa por ponto-e-vírgula
   IFS=''         → Limpa IFS (cada caractere é um campo)
   unset IFS      → Reseta para padrão

═══════════════════════════════════════════════════════════════════
POR QUE -r (READ RAW)?
═══════════════════════════════════════════════════════════════════

A opção -r no comando read impede interpretação de escape sequences.

SEM -r:
   read texto <<< "linha com \ barra"
   # A barra pode ser interpretada como escape

COM -r (recomendado):
   read -r texto <<< "linha com \ barra"
   # A barra é preservada literalmente

═══════════════════════════════════════════════════════════════════
LEITURA DE ARQUIVO LINHA A LINHA (PADRÃO CORRETO)
═══════════════════════════════════════════════════════════════════

Forma SEGURA e RECOMENDADA:

   while IFS= read -r linha; do
       echo "Linha: $linha"
   done < arquivo.txt

Explicação:
   - IFS=       → Limpa o separador (preserva espaços na linha)
   - -r         → Interpreta literalmente (sem escape)
   - < arquivo  → Redireciona o arquivo para entrada do loop

═══════════════════════════════════════════════════════════════════
PROBLEMAS COMUNS SEM IFS= e -r
═══════════════════════════════════════════════════════════════════

Problema 1: Espaços removidos no início/fim
   while read linha; do
   done < arquivo.txt
   # Espaços no início/fim são removidos

Problema 2: Barras invertidas desaparecem
   # Sem -r, \n é interpretado como quebra de linha

Problema 3: Linhas vazias puladas
   # IFS padrão pula linhas em branco

Solução: SEMPRE use "IFS= read -r"

═══════════════════════════════════════════════════════════════════
MODIFICANDO IFS GLOBALMENTE VS LOCALMENTE
═══════════════════════════════════════════════════════════════════

LOCALMENTE (não afeta resto do script):
   IFS=',' read campo1 campo2 <<< "$dados"

GLOBALMENTE (afeta todo o script):
   IFS=','
   read campo1 campo2 <<< "$dados"
   # IFS continua como ',' até ser reseta

Para resetar:
   unset IFS  # Volta ao padrão
   IFS=' '    # Define como espaço

CONCEITOS


###############################################################################
# 📝 PARTE 2: EXEMPLOS PRÁTICOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "EXEMPLOS PRÁTICOS - IFS"
echo "═══════════════════════════════════════════════════════════════════"

# --- EXEMPLO 1: Separação por vírgula ---
echo ""
echo "🔹 EXEMPLO 1: Separar string por vírgula"
echo "─────────────────────────────────────────────────────────────────"

frutas="maçã,banana,laranja,uva"
echo "String original: $frutas"

# Método 1: IFS local (não afeta resto do script)
IFS=',' read -r fruta1 fruta2 fruta3 fruta4 <<< "$frutas"

echo "Frutas separadas:"
echo "  1: $fruta1"
echo "  2: $fruta2"
echo "  3: $fruta3"
echo "  4: $fruta4"


# --- EXEMPLO 2: Separação por dois-pontos ---
echo ""
echo "🔹 EXEMPLO 2: Separar por dois-pontos (como /etc/passwd)"
echo "─────────────────────────────────────────────────────────────────"

# Simular linha de /etc/passwd
usuario_info="root:x:0:0:root:/root:/bin/bash"

IFS=':' read -r usuario senha uid gid nome home shell <<< "$usuario_info"

echo "Informações do usuário:"
echo "  Usuário: $usuario"
echo "  UID: $uid"
echo "  GID: $gid"
echo "  Home: $home"
echo "  Shell: $shell"


# --- EXEMPLO 3: Leitura de arquivo linha a linha ---
echo ""
echo "🔹 EXEMPLO 3: Ler arquivo linha a linha"
echo "─────────────────────────────────────────────────────────────────"

# Criar arquivo de teste
cat > /tmp/lista_pessoas.txt <<EOF
Alice Silva
  Bob Costa   
Carlos Oliveira
EOF

echo "Lendo arquivo com IFS= read -r:"
while IFS= read -r linha; do
    echo "  [$linha]"  # Colchetes mostram espaços
done < /tmp/lista_pessoas.txt

echo ""
echo "Observe que os espaços no início/fim são preservados!"


# --- EXEMPLO 4: Separar múltiplos campos em um loop ---
echo ""
echo "🔹 EXEMPLO 4: Processar CSV com múltiplos campos"
echo "─────────────────────────────────────────────────────────────────"

# Criar arquivo CSV
cat > /tmp/dados.csv <<EOF
João,25,São Paulo
Maria,30,Rio de Janeiro
Pedro,28,Belo Horizonte
EOF

echo "Processando CSV:"
while IFS=',' read -r nome idade cidade; do
    printf "  %-15s %3d anos - %s\n" "$nome" "$idade" "$cidade"
done < /tmp/dados.csv


# --- EXEMPLO 5: Variáveis com espaços em branco ---
echo ""
echo "🔹 EXEMPLO 5: Leitura preservando espaços"
echo "─────────────────────────────────────────────────────────────────"

linha="   Texto com espaços no início e fim   "
echo "Sem IFS= read (perde espaços):"
read texto1 <<< "$linha"
echo "  [$texto1]"

echo "Com IFS= read (preserva espaços):"
IFS= read -r texto2 <<< "$linha"
echo "  [$texto2]"


# --- EXEMPLO 6: Separar por pipe (|) ---
echo ""
echo "🔹 EXEMPLO 6: Separar por pipe"
echo "─────────────────────────────────────────────────────────────────"

dados="apple|10|2.50"
IFS='|' read -r fruta quantidade preco <<< "$dados"

echo "Dados do produto:"
echo "  Fruta: $fruta"
echo "  Quantidade: $quantidade"
echo "  Preço: \$$preco"


# --- EXEMPLO 7: Múltiplos separadores ---
echo ""
echo "🔹 EXEMPLO 7: Usar múltiplos separadores"
echo "─────────────────────────────────────────────────────────────────"

# IFS pode ter múltiplos caracteres
dado="nome:João|idade:25,cidade:SP"

# Separar por : e |
IFS=':' read -r campo1 resto <<< "$dado"
echo "Primeiro campo: $campo1"
echo "Resto: $resto"


# --- EXEMPLO 8: Loop com array ---
echo ""
echo "🔹 EXEMPLO 8: Converter string em array com IFS"
echo "─────────────────────────────────────────────────────────────────"

cores="vermelho,verde,azul,amarelo"

# Converter para array
IFS=',' read -ra array_cores <<< "$cores"

echo "Array de cores:"
for (( i=0; i<${#array_cores[@]}; i++ )); do
    echo "  [$i]: ${array_cores[$i]}"
done


# --- EXEMPLO 9: Ler e processar PATH ---
echo ""
echo "🔹 EXEMPLO 9: Processar variável PATH (com :)"
echo "─────────────────────────────────────────────────────────────────"

# PATH é separado por :
echo "Diretórios no PATH:"
IFS=':' read -ra dirs <<< "$PATH"

for dir in "${dirs[@]:0:5}"; do  # Mostrar apenas os 5 primeiros
    echo "  - $dir"
done


# --- EXEMPLO 10: IFS para parsing de opções ---
echo ""
echo "🔹 EXEMPLO 10: Parser simples com IFS"
echo "─────────────────────────────────────────────────────────────────"

processar_opcao() {
    local opcao="$1"
    
    # Esperado: "chave=valor"
    IFS='=' read -r chave valor <<< "$opcao"
    
    echo "  Chave: $chave"
    echo "  Valor: $valor"
}

echo "Processando opções:"
processar_opcao "nome=Alice"
processar_opcao "idade=25"


###############################################################################
# 🔄 PARTE 3: CASOS DE USO AVANÇADOS
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "CASOS DE USO AVANÇADOS"
echo "═══════════════════════════════════════════════════════════════════"

# --- Ler arquivo /etc/passwd ---
echo ""
echo "🔹 Ler /etc/passwd com IFS"

echo "Primeiros 3 usuários do sistema:"
contador=0
while IFS=':' read -r usuario x uid gid nome home shell; do
    if [[ $uid -ge 1000 ]]; then  # Apenas usuários reais
        echo "  $usuario (UID: $uid)"
        ((contador++))
        if [[ $contador -ge 3 ]]; then
            break
        fi
    fi
done < /etc/passwd


# --- Processar linhas com quoting ---
echo ""
echo "🔹 Processar CSV com aspas"

cat > /tmp/dados_citados.csv <<'CSV'
João,25,"São Paulo, SP"
Maria,30,"Rio de Janeiro, RJ"
CSV

echo "CSV com campos citados:"
while IFS=',' read -r nome idade local; do
    # Remover aspas
    local="${local%\"}"
    local="${local#\"}"
    printf "  %-15s %3d - %s\n" "$nome" "$idade" "$local"
done < /tmp/dados_citados.csv


###############################################################################
# 📊 PARTE 4: TABELA DE REFERÊNCIA
###############################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "TABELA DE REFERÊNCIA"
echo "═══════════════════════════════════════════════════════════════════"

cat << 'TABELA'

┌──────────────────────────┬──────────────────┬─────────────────────────┐
│ Cenário                  │ Comando          │ Exemplo                 │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Separar por vírgula      │ IFS=','          │ IFS=',' read a b c <<<  │
│                          │                  │ "x,y,z"                 │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Separar por :            │ IFS=':'          │ IFS=':' read a b c <<<  │
│                          │                  │ "x:y:z"                 │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Separar por espaço (pad) │ (padrão)         │ read a b c <<< "x y z" │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Preservar espaços        │ IFS=             │ IFS= read -r linha <    │
│                          │ (vazio)          │ arquivo.txt             │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Raw (sem escape)         │ -r flag          │ read -r texto           │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Criar array              │ -a flag          │ IFS=',' read -ra arr    │
│                          │                  │ <<< "a,b,c"             │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Ler arquivo linha por    │ while read       │ while IFS= read -r      │
│ linha                    │ < arquivo        │ linha; do...done <      │
│                          │                  │ arquivo.txt             │
├──────────────────────────┼──────────────────┼─────────────────────────┤
│ Resetar IFS              │ unset IFS        │ unset IFS               │
│                          │ ou IFS=' '       │ ou IFS=$' \t\n'         │
│                          │                  │                         │
└──────────────────────────┴──────────────────┴─────────────────────────┘

TABELA

# Limpeza
rm -f /tmp/lista_pessoas.txt /tmp/dados.csv /tmp/dados_citados.csv

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Script finalizado!"
echo "═══════════════════════════════════════════════════════════════════"
