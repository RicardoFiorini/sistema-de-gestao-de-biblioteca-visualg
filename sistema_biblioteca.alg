algoritmo "Sistema de Gestão de Biblioteca"
variáveis
    // Estruturas para armazenar dados
    tipo Livro
        título : caractere
        autor : caractere
        disponível : lógico
    fimTipo

    tipo Leitor
        nome : caractere
        livroEmprestado : caractere
    fimTipo

    livros : vetor[1..100] de Livro
    leitores : vetor[1..100] de Leitor

    // Contadores de registros
    totalLivros : inteiro
    totalLeitores : inteiro

    opcao : inteiro
    tituloBusca, leitorBusca : caractere
    i, indiceLivro, indiceLeitor : inteiro
início
    totalLivros ← 0
    totalLeitores ← 0

    // Função para cadastrar um livro
    funcao cadastrarLivro()
        totalLivros ← totalLivros + 1
        escreva("Título do livro: ")
        leia(livros[totalLivros].título)
        escreva("Autor do livro: ")
        leia(livros[totalLivros].autor)
        livros[totalLivros].disponível ← verdadeiro
        escreva("Livro cadastrado com sucesso!\n")
    fimfuncao

    // Função para cadastrar um leitor
    funcao cadastrarLeitor()
        totalLeitores ← totalLeitores + 1
        escreva("Nome do leitor: ")
        leia(leitores[totalLeitores].nome)
        leitores[totalLeitores].livroEmprestado ← ""
        escreva("Leitor cadastrado com sucesso!\n")
    fimfuncao

    // Função para buscar índice de um livro pelo título
    funcao buscarLivroPorTitulo(titulo : caractere) : inteiro
        para i de 1 até totalLivros faça
            se livros[i].título = titulo então
                retorne i
            fimse
        fimpara
        retorne 0 // Retorna 0 se o livro não for encontrado
    fimfuncao

    // Função para buscar índice de um leitor pelo nome
    funcao buscarLeitorPorNome(nome : caractere) : inteiro
        para i de 1 até totalLeitores faça
            se leitores[i].nome = nome então
                retorne i
            fimse
        fimpara
        retorne 0 // Retorna 0 se o leitor não for encontrado
    fimfuncao

    // Função para realizar um empréstimo
    funcao emprestarLivro()
        escreva("Digite o título do livro a ser emprestado: ")
        leia(tituloBusca)
        indiceLivro ← buscarLivroPorTitulo(tituloBusca)

        se indiceLivro = 0 então
            escreva("Livro não encontrado.\n")
        senão
            se livros[indiceLivro].disponível = falso então
                escreva("Livro já emprestado.\n")
            senão
                escreva("Digite o nome do leitor: ")
                leia(leitorBusca)
                indiceLeitor ← buscarLeitorPorNome(leitorBusca)

                se indiceLeitor = 0 então
                    escreva("Leitor não encontrado.\n")
                senão
                    livros[indiceLivro].disponível ← falso
                    leitores[indiceLeitor].livroEmprestado ← tituloBusca
                    escreva("Empréstimo realizado com sucesso!\n")
                fimse
            fimse
        fimse
    fimfuncao

    // Função para realizar a devolução de um livro
    funcao devolverLivro()
        escreva("Digite o título do livro a ser devolvido: ")
        leia(tituloBusca)
        indiceLivro ← buscarLivroPorTitulo(tituloBusca)

        se indiceLivro = 0 então
            escreva("Livro não encontrado.\n")
        senão
            se livros[indiceLivro].disponível = verdadeiro então
                escreva("Este livro já está disponível.\n")
            senão
                livros[indiceLivro].disponível ← verdadeiro
                // Encontrar o leitor que possui o livro emprestado
                para i de 1 até totalLeitores faça
                    se leitores[i].livroEmprestado = tituloBusca então
                        leitores[i].livroEmprestado ← ""
                        escreva("Devolução realizada com sucesso!\n")
                        interrompa
                    fimse
                fimpara
            fimse
        fimse
    fimfuncao

    // Função para exibir relatórios
    funcao exibirRelatorios()
        escreva("\n=== Relatório de Livros Disponíveis ===\n")
        para i de 1 até totalLivros faça
            se livros[i].disponível então
                escreva("Título: ", livros[i].título, ", Autor: ", livros[i].autor, "\n")
            fimse
        fimpara

        escreva("\n=== Relatório de Livros Emprestados ===\n")
        para i de 1 até totalLeitores faça
            se leitores[i].livroEmprestado <> "" então
                escreva("Leitor: ", leitores[i].nome, ", Livro: ", leitores[i].livroEmprestado, "\n")
            fimse
        fimpara
    fimfuncao

    // Loop principal do sistema
    repita
        escreva("\n=== Sistema de Gestão de Biblioteca ===\n")
        escreva("1. Cadastrar Livro\n")
        escreva("2. Cadastrar Leitor\n")
        escreva("3. Emprestar Livro\n")
        escreva("4. Devolver Livro\n")
        escreva("5. Exibir Relatórios\n")
        escreva("0. Sair\n")
        escreva("Escolha uma opção: ")
        leia(opcao)

        escolha opcao
            caso 1
                cadastrarLivro()
            caso 2
                cadastrarLeitor()
            caso 3
                emprestarLivro()
            caso 4
                devolverLivro()
            caso 5
                exibirRelatorios()
            caso 0
                escreva("Saindo do sistema...\n")
            caso contrário
                escreva("Opção inválida. Tente novamente.\n")
        fimescolha
    até opcao = 0
fimalgoritmo
