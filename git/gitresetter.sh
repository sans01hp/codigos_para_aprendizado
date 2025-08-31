#!/usr/bin/env bash

# 1. Cria uma nova branch "limpa" com o estado atual do diretório
git checkout --orphan temp

# 2. Adiciona todos os arquivos e cria o commit inicial
git add -A && git commit -m "Novo histórico inicial"

# 3. Substitui a branch principal e força o push
git branch -M main
git push -f origin main
