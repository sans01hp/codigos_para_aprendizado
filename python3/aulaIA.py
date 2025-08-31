#!/usr/bin/env python3
# -------------------------------------------------------------
# Shebang: a linha acima (# ! /usr/bin/env python3)
# indica ao sistema operacional que este script deve ser rodado
# com o interpretador Python 3 disponível no PATH.
# Assim, se o arquivo for executável (chmod +x script.py)
# podemos rodar com: ./script.py
# -------------------------------------------------------------

# Lista de dicionários representando locais
locais = [
    {'tipo': "Apartamento", 'rua': "Catarolas", 'numero': "345"},
    {'tipo': "Residência", 'rua': "Miramar", 'numero': "67"}
]

# Mostrar todas as chaves únicas presentes em todos os dicionários da lista
# O set().union() percorre cada dicionário e junta todas as chaves únicas.
chaves_unicas = set().union(*(local.keys() for local in locais))
print(f"Chaves únicas encontradas nos locais: {chaves_unicas}\n")

# Explicação do len():
# len(locais) retorna quantos elementos há na lista locais.
# Como a contagem de índices começa em 0, o último índice válido é len(locais) - 1.
print(f"A lista 'locais' tem {len(locais)} elementos.")
print(f"Os índices válidos vão de 0 até {len(locais) - 1}.\n")

# Exemplo de uso do for para percorrer todos os dicionários da lista
print("Mostrando todos os locais com um loop for:")
for i, local in enumerate(locais):
    print(f"\nLocal {i}:")
    for chave, valor in local.items():
        print(f"  {chave}: {valor}")

print("\nAgora vamos pedir ao usuário para escolher um índice válido:\n")

# Loop que pede um índice até o usuário digitar corretamente
while True:
    entrada = input(f"Digite um índice de 0 a {len(locais)-1} para mostrar o local correspondente: ")
    try:
        indice = int(entrada)  # tenta converter para inteiro
        if 0 <= indice < len(locais):  # verifica se está dentro do intervalo válido
            local_escolhido = locais[indice]
            print(f"\nLocal escolhido (índice {indice}):")
            # Mostrar todas as chaves e valores do local escolhido
            for chave, valor in local_escolhido.items():
                print(f"  {chave}: {valor}")
            break  # Entrada válida → sai do while True
        else:
            print(f"Erro: índice deve ser entre 0 e {len(locais)-1}. Tente novamente.\n")
    except ValueError:
        print("Entrada inválida! Por favor, digite um número inteiro.\n")

print("\nFim do programa.")
