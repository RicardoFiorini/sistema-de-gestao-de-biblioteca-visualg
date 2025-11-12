# 📚 Sistema de Gestão de Biblioteca (Portugol)

Este é um algoritmo de console robusto, escrito em Portugol, que simula um sistema básico de gerenciamento de biblioteca. O projeto demonstra o uso de **Registros** (`tipo`), vetores, modularização (procedimentos e funções) e validação de dados.



## ✨ Funcionalidades Principais

Este sistema é totalmente orientado a menus e inclui validação de dados para prevenir erros de operação:

* **1. Cadastrar Livro:**
    * Permite adicionar um novo livro (Título, Autor).
    * **Validação:** Impede o cadastro de livros com **títulos duplicados**.
    * **Validação:** Impede o cadastro se o **limite** do vetor (100) for atingido.

* **2. Cadastrar Leitor:**
    * Permite adicionar um novo leitor (Nome).
    * **Validação:** Impede o cadastro de leitores com **nomes duplicados**.
    * **Validação:** Impede o cadastro se o **limite** do vetor (100) for atingido.

* **3. Emprestar Livro:**
    * Gerencia a lógica de empréstimo.
    * **Validação Tripla:** O empréstimo só é permitido se:
        1.  O **livro existir** E
        2.  O livro estiver **disponível** (não emprestado) E
        3.  O **leitor existir** E
        4.  O leitor **não possuir outro livro** emprestado no momento.

* **4. Devolver Livro:**
    * Processa a devolução de um livro.
    * Marca o livro como `disponível`.
    * Limpa o status do leitor que o possuía, liberando-o para novos empréstimos.

* **5. Exibir Relatórios:**
    * Mostra um painel completo com:
        * Lista de todos os livros **disponíveis**.
        * Lista de todos os livros **emprestados** (mostrando qual leitor está com qual livro).

* **6. Interface (UX):**
    * Usa `limpatela` para manter o console limpo.
    * Usa uma função `Pausar()` ("Pressione ENTER...") para que o usuário possa ler as mensagens de sucesso ou erro antes de voltar ao menu.
    * O menu principal exibe um **contador** de livros e leitores (ex: `Livros: 5/100`).

## 🏛️ Estrutura e Lógica

O sistema é baseado em duas estruturas (Registros) principais:

1.  **`tipo Livro`**:
    * `título` (caractere)
    * `autor` (caractere)
    * `disponível` (logico) - *Controla se o livro pode ser emprestado.*

2.  **`tipo Leitor`**:
    * `nome` (caractere)
    * `livroEmprestado` (caractere) - *Armazena o **título** do livro que o leitor pegou, ou "" se não tiver nenhum.*

Todo o código é modularizado. Funções (`funcao`) são usadas para **buscar** dados e retornar valores (ex: `buscarLivroPorTitulo`), enquanto Procedimentos (`procedimento`) são usados para **executar ações** (ex: `cadastrarLivro`, `emprestarLivro`).

## 🚀 Como Executar

Para executar este algoritmo, você precisará de um interpretador de Portugol.

1.  **VisualG (Recomendado):**
    * Baixe e instale o [VisualG](http://visualg.com.br/cli/).
    * Copie o código-fonte (`.alg`) do arquivo.
    * Abra o VisualG e cole o código.
    * Pressione **F9** (ou clique em "Rodar") para executar o programa.
