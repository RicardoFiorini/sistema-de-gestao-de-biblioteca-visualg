algoritmo "Sistema de Gestão de Biblioteca Aprimorado"

// --- Constantes de Limite ---
const
   LIMITE_LIVROS = 100
   LIMITE_LEITORES = 100

// --- Definição dos Tipos (Registros) ---
// (Deve ser feito ANTES do bloco 'var')
tipo Livro
   título: caractere
   autor: caractere
   disponível: logico
fimTipo

tipo Leitor
   nome: caractere
   livroEmprestado: caractere // Armazena o TÍTULO do livro
fimTipo

// --- Variáveis Globais ---
var
   livros: vetor[1..LIMITE_LIVROS] de Livro
   leitores: vetor[1..LIMITE_LEITORES] de Leitor
   
   totalLivros: inteiro
   totalLeitores: inteiro
   
   opcao: inteiro

// --- Procedimento: Pausa a execução ---
procedimento Pausar()
var
   tecla: caractere
inicio
   escreva("\n(Pressione [ENTER] para voltar ao menu...)")
   leia(tecla)
fimprocedimento

// --- Função: Buscar Livro (Retorna o índice ou 0) ---
// (Correta como 'funcao')
funcao buscarLivroPorTitulo(titulo: caractere) : inteiro
var
   i: inteiro
inicio
   para i de 1 até totalLivros faca
      se (livros[i].título = titulo) entao
         retorne i
      fimse
   fimpara
   retorne 0 // Não encontrado
fimfuncao

// --- Função: Buscar Leitor (Retorna o índice ou 0) ---
// (Correta como 'funcao')
funcao buscarLeitorPorNome(nome: caractere) : inteiro
var
   i: inteiro
inicio
   para i de 1 até totalLeitores faca
      se (leitores[i].nome = nome) entao
         retorne i
      fimse
   fimpara
   retorne 0 // Não encontrado
fimfuncao

// --- Procedimento: Cadastrar Livro (com validação) ---
// (Corrigido para 'procedimento')
procedimento cadastrarLivro()
var
   novoTitulo, novoAutor: caractere
inicio
   limpatela
   escreva("--- Cadastro de Livro ---\n")

   // 1. Validação de Limite
   se (totalLivros >= LIMITE_LIVROS) entao
      escreva("[ERRO] Limite de (", LIMITE_LIVROS, ") livros atingido!\n")
      retorne // Sai do procedimento
   fimse

   escreva("Digite o Título: ")
   leia(novoTitulo)

   // 2. Validação de Duplicatas
   se (buscarLivroPorTitulo(novoTitulo) > 0) entao
      escreva("\n[ERRO] Um livro com este título já existe!\n")
      retorne // Sai do procedimento
   fimse

   escreva("Digite o Autor: ")
   leia(novoAutor)

   // 3. Adicionar ao vetor
   totalLivros <- totalLivros + 1
   livros[totalLivros].título <- novoTitulo
   livros[totalLivros].autor <- novoAutor
   livros[totalLivros].disponível <- verdadeiro

   escreva("\nLivro cadastrado com sucesso! (ID: ", totalLivros, ")\n")
fimprocedimento

// --- Procedimento: Cadastrar Leitor (com validação) ---
// (Corrigido para 'procedimento')
procedimento cadastrarLeitor()
var
   novoNome: caractere
inicio
   limpatela
   escreva("--- Cadastro de Leitor ---\n")

   // 1. Validação de Limite
   se (totalLeitores >= LIMITE_LEITORES) entao
      escreva("[ERRO] Limite de (", LIMITE_LEITORES, ") leitores atingido!\n")
      retorne
   fimse

   escreva("Digite o Nome do Leitor: ")
   leia(novoNome)

   // 2. Validação de Duplicatas (simples, pelo nome)
   se (buscarLeitorPorNome(novoNome) > 0) entao
      escreva("\n[ERRO] Um leitor com este nome já existe!\n")
      retorne
   fimse

   // 3. Adicionar ao vetor
   totalLeitores <- totalLeitores + 1
   leitores[totalLeitores].nome <- novoNome
   leitores[totalLeitores].livroEmprestado <- "" // Inicia sem livro

   escreva("\nLeitor cadastrado com sucesso! (ID: ", totalLeitores, ")\n")
fimprocedimento

// --- Procedimento: Emprestar Livro (com validação) ---
// (Corrigido para 'procedimento' e adicionada validação de leitor)
procedimento emprestarLivro()
var
   tituloBusca, leitorBusca: caractere
   indiceLivro, indiceLeitor: inteiro
inicio
   limpatela
   escreva("--- Realizar Empréstimo ---\n")
   
   escreva("Digite o título do livro: ")
   leia(tituloBusca)
   indiceLivro <- buscarLivroPorTitulo(tituloBusca)

   // Validação do Livro
   se (indiceLivro = 0) entao
      escreva("\n[ERRO] Livro não encontrado.\n")
   senao se (livros[indiceLivro].disponível = falso) entao
      escreva("\n[ERRO] Este livro já está emprestado.\n")
   senao
      // Se o livro está OK, busca o leitor
      escreva("Digite o nome do leitor: ")
      leia(leitorBusca)
      indiceLeitor <- buscarLeitorPorNome(leitorBusca)

      // Validação do Leitor
      se (indiceLeitor = 0) entao
         escreva("\n[ERRO] Leitor não encontrado.\n")
      // ---- MELHORIA CRÍTICA ----
      senao se (leitores[indiceLeitor].livroEmprestado <> "") entao
         escreva("\n[ERRO] Este leitor já possui um livro emprestado!\n")
         escreva("       (Livro: ", leitores[indiceLeitor].livroEmprestado, ")\n")
      senao
         // Se ambos estão OK, realiza o empréstimo
         livros[indiceLivro].disponível <- falso
         leitores[indiceLeitor].livroEmprestado <- livros[indiceLivro].título // Salva o título no leitor
         escreva("\nEmpréstimo realizado com sucesso!\n")
         escreva(leitores[indiceLeitor].nome, " emprestou '", livros[indiceLivro].título, "'\n")
      fimse
   fimse
fimprocedimento

// --- Procedimento: Devolver Livro ---
// (Corrigido para 'procedimento')
procedimento devolverLivro()
var
   tituloBusca: caractere
   indiceLivro, i: inteiro
   leitorEncontrado: logico
inicio
   limpatela
   escreva("--- Realizar Devolução ---\n")
   
   escreva("Digite o título do livro a ser devolvido: ")
   leia(tituloBusca)
   indiceLivro <- buscarLivroPorTitulo(tituloBusca)
   
   se (indiceLivro = 0) entao
      escreva("\n[ERRO] Livro não encontrado.\n")
   senao se (livros[indiceLivro].disponível = verdadeiro) entao
      escreva("\n[ERRO] Este livro já consta como 'disponível'.\n")
   senao
      // 1. Marca o livro como disponível
      livros[indiceLivro].disponível <- verdadeiro
      leitorEncontrado <- falso

      // 2. Encontra o leitor que estava com ele e limpa seu status
      para i de 1 até totalLeitores faca
         se (leitores[i].livroEmprestado = tituloBusca) entao
            leitores[i].livroEmprestado <- ""
            escreva("\nDevolução realizada com sucesso!\n")
            escreva("O leitor '", leitores[i].nome, "' devolveu o livro.\n")
            leitorEncontrado <- verdadeiro
            interrompa // Para o 'para'
         fimse
      fimpara
      
      se (leitorEncontrado = falso) entao
         // Isso é um "estado impossível" se a lógica estiver correta,
         // mas é uma boa verificação de segurança.
         escreva("\n[AVISO] Livro marcado como devolvido, mas nenhum leitor foi encontrado com ele.\n")
      fimse
   fimse
fimprocedimento

// --- Procedimento: Exibir Relatórios ---
// (Corrigido para 'procedimento')
procedimento exibirRelatorios()
var
   i: inteiro
   contDisponiveis, contEmprestados: inteiro
inicio
   limpatela
   contDisponiveis <- 0
   contEmprestados <- 0
   
   escreva("=========================================\n")
   escreva("=       RELATÓRIO DA BIBLIOTECA       =\n")
   escreva("=========================================\n")
   

   escreva("\n--- Livros Disponíveis (", totalLivros, " total) ---\n")
   para i de 1 até totalLivros faca
      se (livros[i].disponível) entao
         escreva("  - Título: ", livros[i].título, " (Autor: ", livros[i].autor, ")\n")
         contDisponiveis <- contDisponiveis + 1
      fimse
   fimpara
   se (contDisponiveis = 0) entao
      escreva("  (Nenhum livro disponível no momento)\n")
   fimse

   escreva("\n--- Livros Emprestados ---\n")
   // É mais eficiente iterar pelos leitores, como no original
   para i de 1 até totalLeitores faca
      se (leitores[i].livroEmprestado <> "") entao
         escreva("  - Leitor: ", leitores[i].nome, " -> Livro: ", leitores[i].livroEmprestado, "\n")
         contEmprestados <- contEmprestados + 1
      fimse
   fimpara
   se (contEmprestados = 0) entao
      escreva("  (Nenhum livro emprestado no momento)\n")
   fimse
   
   escreva("\n=========================================\n")
fimprocedimento

// --- Bloco Principal (Início da Execução) ---
inicio
   // Inicializa os contadores
   totalLivros <- 0
   totalLeitores <- 0
   opcao <- -1 // Inicia com valor diferente de 0

   // Loop principal do sistema
   repita
      limpatela
      escreva("=========================================\n")
      escreva("=    Sistema de Gestão de Biblioteca    =\n")
      escreva("=========================================\n")
      escreva(" Livros: ", totalLivros, "/", LIMITE_LIVROS, " | Leitores: ", totalLeitores, "/", LIMITE_LEITORES, "\n")
      escreva("=========================================\n")
      escreva("1. Cadastrar Livro\n")
      escreva("2. Cadastrar Leitor\n")
      escreva("3. Emprestar Livro\n")
      escreva("4. Devolver Livro\n")
      escreva("5. Exibir Relatórios\n")
      escreva("0. Sair\n")
      escreva("-----------------------------------------\n")
      escreva("Escolha uma opção: ")
      leia(opcao)

      escolha opcao
         caso 1
            cadastrarLivro()
            Pausar()
         caso 2
            cadastrarLeitor()
            Pausar()
         caso 3
            emprestarLivro()
            Pausar()
         caso 4
            devolverLivro()
            Pausar()
         caso 5
            exibirRelatorios()
            Pausar()
         caso 0
            escreva("\nSaindo do sistema... Obrigado!\n")
         padrão
            escreva("\n[ERRO] Opção inválida. Tente novamente.\n")
            Pausar()
      fimescolha
      
   até (opcao = 0)
fimalgoritmo
