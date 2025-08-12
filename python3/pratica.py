
import requests
import sys

#file = open()

#for cor in file:

urls = sys.argv[1]

status_code = [ 200, 403, 402, 301 ]
# print(cor)
def verifica_url(dominio, sc_valido):
    
    if "https://" not in dominio:
        dominio = f"https://{dominio}"
        
    try:
        r= requests.get(dominio)

        if  r.status_code in sc_valido:
             print("dominio ativo")
             print(f"resposta={r.status_code}")
    except:
        print("dominio invalido ou nao listado")        
        print(r.status_code)
        
         

verifica_url(urls, status_code)   
