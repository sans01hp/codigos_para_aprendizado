#!/usr/bin/env python3
"""
Script para automação no Kali Linux
Reescrita do script Bash original para Python 3
Autor: Adaptado por ChatGPT
"""
#Modificação do script instaladorlinux.sh para uma versão em Python3 para estudos.
import os
import subprocess
import time
import sys

def print_color(text, color_code):
    """Imprime texto com código de cor ANSI"""
    print(f"\033[{color_code}m{text}\033[0m")

def main():
    print_color(
        "Esse script foi feito com o propósito de ser usado no Kali para o userland",
        "93"
    )
    time.sleep(2)

    # Verifica se o sistema é Linux
    if os.uname().sysname != "Linux":
        print_color("Você não está usando um sistema GNU/Linux ou similar", "1;32")
        sys.exit(1)

    os.system("clear")
    print_color("Vamos começar atualizando o Linux...", "1;36")
    time.sleep(3)

    home_dir = os.path.expanduser("~")
    os.chdir(home_dir)

    # Atualiza repositórios
    subprocess.run(["sudo", "apt", "update", "-y"])

    os.system("clear")
    print_color("Instalando linguagens de programação e ferramentas necessárias....", "36")
    time.sleep(3)

    # Instala pacotes essenciais
    pacotes = ["python3", "pypy3-venv", "golang", "curl", "wget"]
    for pacote in pacotes:
        subprocess.run(["sudo", "apt", "install", pacote, "-y"])

    os.system("clear")
    print_color("Instalando ferramentas em Golang...", "36")
    time.sleep(3)

    # Dicionário de ferramentas Go
    ferramentas = {
        "kxss": "github.com/Emoe/kxss@latest",
        "subfinder": "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest",
        "httpx": "github.com/projectdiscovery/httpx/cmd/httpx@latest",
        "gau": "github.com/lc/gau/v2/cmd/gau@latest",
        "anew": "github.com/tomnomnom/anew@latest",
        "ffuf": "github.com/ffuf/ffuf@latest",
        "getJS": "github.com/003random/getJS@latest"
    }

    for nome, repo in ferramentas.items():
        print_color(f"Instalando {nome}...", "92")
        time.sleep(1)
        subprocess.run(["go", "install", "-v", repo])

    os.system("clear")

    print_color("Baixando repositórios de outras ferramentas necessárias para o script testadordeurl...", "36")
    print_color("Algumas ferramentas possuem instalações diferentes. Verifique como instalar as ferramentas pesquisando elas em https://github.com", "91")
    print_color("Baixando pipx", "92")

    subprocess.run(["sudo", "apt", "install", "pipx", "-y"])
    time.sleep(3)

    # Dicionário de repositórios para clonar
    repositorios = {
        "ParamSpider": "https://github.com/devanshbatham/ParamSpider",
        "Cam-Hackers": "https://github.com/AngelSecurityTeam/Cam-Hackers",
        "EyeSeeYou": "https://github.com/BraydenP07/EyeSeeYou",
        "sherlock": "https://github.com/sherlock-project/sherlock",
        "git-dumper": "https://github.com/arthaud/git-dumper",
        "zphisher": "https://github.com/htr-tech/zphisher",
        "cam-finder": "https://github.com/member87/cam-finder.git",
        "sqlmap": "https://github.com/sqlmapproject/sqlmap",
        "https-github.com-Rajkumrdusad-Tool-X": "https://github.com/vaibhavguru/https-github.com-Rajkumrdusad-Tool-X.git"
    }

    for repo, url in repositorios.items():
        if not os.path.isdir(repo):
            print(f"Clonando {repo}...")
            subprocess.run(["git", "clone", url])
        else:
            print_color(f"Atualizando o repositório {repo}...", "92")
            subprocess.run(["git", "-C", repo, "reset", "--hard"])
            subprocess.run(["git", "-C", repo, "pull"])

    # Cria ambiente virtual
    venv_path = os.path.join("venv/tools")
    subprocess.run(["python3", "-m", "venv", venv_path])
    activate_script = os.path.join(home_dir, venv_path, "bin", "activate")

    # Ativar virtualenv e instalar pacotes Python
    print_color("Instalando pacotes Python dentro do venv...", "1;92")
    for repo in repositorios:
        repo_path = os.path.join(".", repo)
        setup_py = os.path.join(repo_path, "setup.py")
        pyproject = os.path.join(repo_path, "pyproject.toml")

        if os.path.isfile(setup_py) or os.path.isfile(pyproject):
            print_color(f"Tentando instalar {repo} com pip", "1;92")
            # Executa o pip dentro do ambiente virtual
            subprocess.run(
                f"source {activate_script} && pip install {repo_path}",
                shell=True, executable="/bin/bash"
            )
        else:
            print_color(f"Repositório {repo} não é um pacote Python instalável. Instalação manual será necessária.", "1;93")

        # Tenta copiar o binário, se existir
        bin_path = os.path.join(home_dir, venv_path, "bin", repo)
        if os.path.isfile(bin_path):
            subprocess.run(["sudo", "cp", bin_path, "/usr/local/bin/"])
        else:
            print_color(f"Executável {repo} não encontrado no venv/bin", "1;93")

    os.system("clear")
    print_color("Instalação concluída", "1;92")
    time.sleep(3)
    os.system("clear")

    # Copia binários Go para /usr/local/bin
    subprocess.run("sudo cp ~/go/bin/* /usr/local/bin", shell=True, executable="/bin/bash")

    # Avisos finais
    print_color("Aviso: As ferramentas em Golang foram copiadas para /usr/local/bin para facilitar o uso.", "93")
    print("Agora você pode executar os comandos diretamente pelo nome da ferramenta:")
    print("Ex1: subfinder -d alvo")
    print("Ex2: ffuf -u alvo/FUZZ -w caminho_da_wordlist")
    print("Ex3: nuclei -u alvo -t ~/nuclei-templates/cves")

if __name__ == "__main__":
    main()
