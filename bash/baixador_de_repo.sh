#!/bin/bash

# Definir o nome do usuário e o nome do repositório a duas variavéis no codigo
username="Sans01hp"   # Altere aqui o nome do dono do repositório que onde deseja baixar o repositório
reponame="testes_shellscript"   # Altere aqui o nome do repositorio que deseja baixar


# Faz a verificação se esse diretorio/repositório ja existe.
if [ -d "$reponame" ]; then
    echo -e "\e[92mRepositório já instalado.\e[0m"
echo -e "deseja instalar a versão mais recente?(y/n)"

read escolha #variavel "escolha" irá armazenar a resposta (y/n) para comparar com o bloco case
case $escolha in 
y|Y) 
     cd ~/$reponame
     git reset --hard 
     git pull
     ;;
n|N) 
     echo -e "instalação cancelada"    
     exit 0
     ;;
*)
     echo -e "operação invalida, saindo..."
     exit 1
     ;;
esac
    

else 

# Clonar o repositório
      git clone https://github.com/$username/$reponame
fi
