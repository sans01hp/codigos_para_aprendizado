#!/usr/bin/env python3
import requests
import sys

# Lista de códigos HTTP considerados como "ativos"
STATUS_CODES_ATIVOS = [200, 201, 202, 301, 302]

# Cria lista de domínios com base nos argumentos (separando por vírgula caso o usuário digite assim)
dominios = []
for arg in sys.argv[1:]:
    dominios.extend(arg.split(","))  # divide argumentos separados por vírgula

# Corrige URLs para garantir http:// ou https://
def corrigir_url(url):
    return url if url.startswith(("http://", "https://")) else f"http://{url}"

# Retorna status code do domínio
def status_dominio(url):
    return requests.get(corrigir_url(url), timeout=5).status_code

# Retorna True se o código estiver na lista de ativos
def esta_ativo(code):
    return code in STATUS_CODES_ATIVOS

# Adiciona domínio na lista
def adicionar(dominio):
    dominios.append(dominio)
    return dominios

# Remove domínio da lista se existir
def remover(dominio):
    if dominio in dominios:
        dominios.remove(dominio)
    return dominios

# Verifica todos os domínios e retorna tuplas (domínio, código)
def verificar_todos():
    return [(d, status_dominio(d)) for d in dominios]

# Mostra resultados formatados
def mostrar_resultados():
    for dominio, code in verificar_todos():
        status = "Ativo" if esta_ativo(code) else "Inativo"
        print(f"{corrigir_url(dominio)} - {code} - {status}")

if __name__ == "__main__":
    if not dominios:
        print(f"Uso: {sys.argv[0]} dominio1 dominio2 ...")
        sys.exit(1)
    mostrar_resultados()
