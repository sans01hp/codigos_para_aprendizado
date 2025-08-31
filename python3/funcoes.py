#!/usr/bin/env python3
import sys
import requests

# =========================================================
# Funções para Status Codes (sc)
# =========================================================
def adicionar_sc(valor, lista_sc):
    """Adiciona um status code à lista"""
    lista_sc.append(valor)

def remover_sc(valor, lista_sc):
    """Remove um status code da lista, se existir"""
    if valor in lista_sc:
        lista_sc.remove(valor)
        return lista_sc[posicao]

def somarlista_sc(lista1, lista2):
    """Concatena duas listas de status codes"""
    return lista1 + lista2

def contar_na_lista_sc(valor, lista_sc):
    """Conta quantas vezes o valor aparece na lista"""
    return lista_sc.count(valor)


# =========================================================
# Funções para Domínios
# =========================================================
def adicionar_dom(dominio, lista_dom):
    lista_dom.append(dominio)

def remover_dom(dominio, lista_dom):
    if dominio in lista_dom:
        lista_dom.remove(dominio)

def checar_dom(dominio, lista_dom):
    return dominio in lista_dom

def pegar_dom(posicao, lista_dom):
    return lista_dom[posicao]

def somarlista_dom(lista1, lista2):
    return lista1 + lista2

def contar_na_lista_dom(dominio, lista_dom):
    return lista_dom.count(dominio)


# =========================================================
# Funções para Dicionário (key -> value)
# =========================================================
def adicionar_dict(chave, valor, dicionario):
    dicionario[chave] = valor

def remover_dict(chave, dicionario):
    if chave in dicionario:
        del dicionario[chave]

def checar_dict(chave, dicionario):
    return chave in dicionario

def pegar_dict(chave, dicionario):
    return dicionario.get(chave)

def mesclar_dict(dict1, dict2):
    novo = dict1.copy()
    novo.update(dict2)
    return novo

def contar_valor_dict(valor, dicionario):
    return list(dicionario.values()).count(valor)


# =========================================================
# Testes rápidos (apenas quando rodar diretamente)
# =========================================================
if __name__ == "__main__":
    # Testando listas de status codes
    lista_sc = [200, 404, 500]
    adicionar_sc(302, lista_sc)
    print("Lista SC:", lista_sc)
    remover_sc(404, lista_sc)
    print("SC após remover:", lista_sc)
    print("Checar 200:", checar_sc(200, lista_sc))
    print("Pegar SC pos 1:", pegar_sc(1, lista_sc))
    print("Contar 500:", contar_na_lista_sc(500, lista_sc))

    # Testando listas de domínios
    lista_dom = ["google.com", "openai.com"]
    adicionar_dom("github.com", lista_dom)
    print("\nLista Domínios:", lista_dom)
    print("Checar openai.com:", checar_dom("openai.com", lista_dom))
    print("Contar google.com:", contar_na_lista_dom("google.com", lista_dom))

    # Testando dicionário
    dic = {"a": 1, "b": 2}
    adicionar_dict("c", 3, dic)
    print("\nDicionário:", dic)
    remover_dict("b", dic)
    print("Após remover b:", dic)
    print("Checar chave 'a':", checar_dict("a", dic))
    print("Valor da chave 'c':", pegar_dict("c", dic))
    print("Contar valor 3:", contar_valor_dict(3, dic))
    
