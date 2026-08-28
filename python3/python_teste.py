import unittest
import doctest
import json
import os
from pathlib import Path


# ==============================================================================
# REGRAS DE NEGÓCIO (SISTEMA DE ESTOQUE)
# ==============================================================================

class Produto:
    """
    Representa um produto no estoque.

    Exemplo usando Doctest:
    >>> p = Produto("Notebook", 2500.00, 5)
    >>> p.preco
    2500.0
    >>> p.atualizar_estoque(-2)
    >>> p.estoque
    3
    >>> p.atualizar_estoque(-10)
    Traceback (most recent call last):
        ...
    ValueError: Estoque insuficiente.
    """
    def __init__(self, nome: str, preco: float, estoque: int):
        if preco < 0:
            raise ValueError("O preço não pode ser negativo.")
        if estoque < 0:
            raise ValueError("O estoque inicial não pode ser negativo.")
        
        self.nome = nome
        self.preco = float(preco)
        self.estoque = int(estoque)

    def atualizar_estoque(self, quantidade: int):
        if self.estoque + quantidade < 0:
            raise ValueError("Estoque insuficiente.")
        self.estoque += quantidade

    def to_dict(self):
        return {"nome": self.nome, "preco": self.preco, "estoque": self.estoque}


class GerenciadorEstoque:
    def __init__(self, arquivo_db: str = "estoque_temp.json"):
        self.arquivo_db = Path(arquivo_db)
        self.produtos = {}

    def adicionar_produto(self, produto: Produto):
        self.produtos[produto.nome] = produto

    def salvar_em_disco(self):
        dados = {nome: p.to_dict() for nome, p in self.produtos.items()}
        with open(self.arquivo_db, "w", encoding="utf-8") as f:
            json.dump(dados, f)

    def carregar_do_disco(self):
        if not self.arquivo_db.exists():
            raise FileNotFoundError("Arquivo de dados não encontrado.")
            
        with open(self.arquivo_db, "r", encoding="utf-8") as f:
            dados = json.load(f)
            self.produtos = {
                nome: Produto(info["nome"], info["preco"], info["estoque"])
                for nome, info in dados.items()
            }


# ==============================================================================
# SUÍTE DE TESTES (UNITTEST)
# ==============================================================================

class TesteUnitarioProduto(unittest.TestCase):
    """1. TESTES UNITÁRIOS: Testam unidades isoladas de código."""

    def test_criacao_produto_valido(self):
        p = Produto("Teclado", 150.0, 10)
        self.assertEqual(p.nome, "Teclado")
        self.assertEqual(p.preco, 150.0)
        self.assertEqual(p.estoque, 10)

    def test_atualizar_estoque_com_sucesso(self):
        p = Produto("Mouse", 80.0, 5)
        p.atualizar_estoque(3)
        self.assertEqual(p.estoque, 8)


class TesteRegressaoEBorda(unittest.TestCase):
    """2. TESTES DE REGRESSÃO E CASOS DE BORDA: Garantem que erros antigos/limites não passem."""

    def test_erro_ao_criar_produto_com_preco_negativo(self):
        with self.assertRaises(ValueError):
            Produto("Cadeira", -50.0, 1)

    def test_erro_ao_remover_mais_estoque_do_que_o_disponivel(self):
        p = Produto("Monitor", 900.0, 2)
        with self.assertRaises(ValueError):
            p.atualizar_estoque(-3)

    def test_comportamento_limite_estoque_zero(self):
        p = Produto("Fone", 50.0, 1)
        p.atualizar_estoque(-1)  # Deve chegar a zero sem lançar exceção
        self.assertEqual(p.estoque, 0)


class TesteIntegracaoEstoque(unittest.TestCase):
    """3. TESTES DE INTEGRAÇÃO: Testam a interação com o sistema de arquivos (I/O)."""

    def setUp(self):
        """Executado ANTES de cada teste de integração."""
        self.arquivo_teste = "teste_integracao_db.json"
        self.gerenciador = GerenciadorEstoque(self.arquivo_teste)

    def tearDown(self):
        """Executado DEPOIS de cada teste de integração para limpar o ambiente."""
        if os.path.exists(self.arquivo_teste):
            os.remove(self.arquivo_teste)

    def test_persistencia_e_recuperacao_de_dados(self):
        # 1. Adiciona dados na memória
        p1 = Produto("USB Hub", 45.0, 20)
        self.gerenciador.adicionar_produto(p1)

        # 2. Salva no disco
        self.gerenciador.salvar_em_disco()
        self.assertTrue(os.path.exists(self.arquivo_teste))

        # 3. Cria novo gerenciador e carrega do arquivo
        novo_gerenciador = GerenciadorEstoque(self.arquivo_teste)
        novo_gerenciador.carregar_do_disco()

        # 4. Asserta que os dados integrados bateram
        self.assertIn("USB Hub", novo_gerenciador.produtos)
        self.assertEqual(novo_gerenciador.produtos["USB Hub"].preco, 45.0)


# ==============================================================================
# EXECUÇÃO DOS TESTES
# ==============================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("1. EXECUTANDO DOCTESTS (Validação de Documentação)")
    print("=" * 60)
    resultado_doctest = doctest.testmod(verbose=True)
    
    print("\n" + "=" * 60)
    print("2. EXECUTANDO UNITTESTS (Unitários, Integração e Regressão)")
    print("=" * 60)
    # Executa a suíte de testes com verbosidade para detalhar a saída no terminal
    unittest.main(exit=False, verbosity=2)