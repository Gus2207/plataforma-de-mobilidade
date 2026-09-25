# Plataforma de mobilidade
## Tema
Mobilidade Urbana e Transporte Coletivo
## Integrantes
Gustavo Barbosa Bento RA145106
Munir Berg Shehadeh RA145103
## Trabalho desenvolvido
O sistema simplificado foi implementado baseando-se nas funcionalidades F1 a F10 descritas na sessão "Funcionalidades implementadas". O código é um sistema base e não possui uma interface para cadastro, consulta ou edição de informações, suas funções foram implementadas de maneira superficial com ênfase em integras as funcionalidades requeridas no trabalho.
Como mencionado acima a implementação foi feita como uma base para um sistema de mobilidade urbana e transporte coletivo,
com o objetivo de representas viagens que foram realizadas de uma cidade, visando gerenciar um cadastro simplificado das informações em um sistema, validando dados e em alguns casos trazendo estatisticas de dados cadastrados.
## Tipos criados
Todos os tipos criados estão dentro do arquivo tipos.gleam com as especificações descritas detalhando a representação de cada tipo de dado
**Viagem**
Um tipo estrutura (tipo produto) opaca utilizada para representar uma viagem realizada.
**Transporte**
Uma enumeração (tipo soma) para representar o transporte utilizado em uma viagem
**Situaco**
Uma enumeração (tipo soma) utilizada para representar a Situação de uma viagem
**Linha**
Um tipo estrutura (tipo produto) utilizado para representar uma linha de viagens
**Regiao**
Um tipo estrutura (tipo produto) utilizado para representar uma região e subregiões de uma região. Além disso, uma região possui diversas linhas de viagem
**Cidade**
Um tipo estrutura (tipo produto) utilizado para representar uma cidade, que por sua vez possui diversas regiões
## Separação dos módulos
Os módulos foram dividos de acordo com sugestões feitas na especificação do trabalho, cada módulo possui responsabilidades descritas abaixo: 
**analise**
Realizar a analise de de dados refentes a um dos tipos de dados descritos anterioremente
**hierarquia**
Percorrer a hierarquia estabelecida junto ao tempo Cidade -> Região -> Linha -> Viagem
**tipos**
Armaenar os tipos de dados criados e realizar validações para a crição de cada tipo, se necessário
**listas**
Manipular listas, extraindo dados, criando novas listas a partir de outras listas, entre outras operações

*Modulos de Teste*
Os testes do sistema são realizados pelo check.eq que valida os resultados das funções nos arquivos mencionados acima, qualquer novo teste deve ser inserido dentro do arquivo *_test referente ao respectivo módulo a ser testado. Utilize o comando .\sgleam -t nome_modulo_test.gleam para verificar quais teste geraram erros e quais deram certo.

Relação dos módulos de testes:
validacao_test.gleam -> tipos.gleam
hierarquia_test.gleam -> hierarquia.gleam
listas_test.gleam -> listas.gleam
analise_test.gleam -> analise.gleam


tema, integrantes, breve descrição do sistema, tipos criados, relação entre
as funcionalidades F1–F10 e as funções que as implementam, além das instruções para execução
dos testes.

 ### Funcionalidades implementadas
 
 - **F1 – Criação e Validação**
   * **Funções utilizadas:** cria_viagem
   * **Realiza:** Recebe os dados de uma possível viagem e verifica se tempo_previsto, tempo_realizado, id e qtd_passageiros são valores válidos para a criação da viagem. Isso em um Tipo Opaco.
   
 
 - **F2 – Classificação**
   * **Funções utilizadas:** classifica_transporte e classifica_tempo
   * **Realiza:** Classifica o transporte da viagem com base na quantidade de passageiros que irão na viagem e o a situação da viagem de acordo com o tempo previso e o tempo realizado da viagem.
 
 - **F3 – Agregação sobre lista**
   * **Funções utilizadas:** conta_elementos, soma_tempo_realizado, media_tempo
   * **Realiza:** Informa a quantidade de viagens em uma linha (com base em sua lista de viagens), realiza a soma do tempo realizado de uma lista de viagens e calcula a media do tempo realizado de uma lista de viagens
 
 - [x] **F4 – Filtragem recursiva**
   * **Funções utilizadas:** filtra_nao_atradadas
   * **Realiza:** Cria uma nova lista de viagens a partir de outra lista do mesmo tipo, mas sem as viagens com situação atrasada.
 
 - [x] **F5 – Transformação recursiva**
   * **Funções utilizadas:** transforma_lista_viagem
   * **Realiza:** Cria uma lista de interios onde cada elementos representa o tempo realizado de uma viagem, essa lista é gerada a partir de uma lista de viagens
 
 - [x] **F6 – Busca**
   * **Funções utilizadas:** busca_elemento
   * **Realiza:** Busca em uma lista de viagens a viagem associada a um id especifico
 
 - [x] **F7 – Maior ou menor elemento**
   * **Funções utilizadas:** viagem_adiantada
   * **Realiza:** Busca a viagem mais adiatada em uma lista de viagens. Insto é com o menor tempo_realizado, mas com Situação Adiantada
 
 - [x] **F8 – Análise combinada**
   * **Funções utilizadas:** media_tempo
   * **Realiza:** Calcula a media do tempo realizado de uma lista de viagens
 
 - [x] **F9 – Processamento hierárquico**
   * **Funções utilizadas:** 
   * Escopo 1 (busca_viagens_onibus, percorre_reagioes, calcula_regiao, percorre_lista_linhas e percorre_viagens_onibus)
   * Escopo 2 (busca_viagens_totais, percorre_regioes_totais, calcula_regiao_totais, percorre_lista_linhas_totais e percorre_viagens_totais)
   * **Realiza:** Ambos os escopos utilizam de funções auxiliares para percorrer toda a estrutura hierarquica. Escopo 1 realiza a contagem de todas as viagens realizadas de ônibus em uma cidade. Enquanto o Escopo 2 realiza a contagem total de viagens realizadas em uma cidade
 
 - [x] **F10 – Relatório textual**
   * **Funções utilizadas:** informacoes_linha
   * **Realiza:** Informa o tempo médio de viagens de uma linha, a viagem mais adiantada e o total de viagens realizadas naquela linha. Isto utilizando as funções anteriores que calculam os dados
