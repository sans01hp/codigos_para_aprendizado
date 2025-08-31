#!/usr/bin/env python3

import sys
sys.path.insert(0, './libs')  # Adiciona a pasta 'libs' ao caminho de importação

from saudacoes import ola

nome = input("Digite seu nome: ")
print(ola(nome))
