# Plataforma de mobilidade - Gleam
## Contexto
Registros de viagens, linhas e atrasos de transporte.
## Dados mínimos sugeridos
id, linha, passageiros, tempo previsto, tempo realizado, situação.
## Tipos soma sugeridos
Adiantado / Pontual / Atrasado / Critico; Onibus / MicroOnibus / Van.
## Estrutura hierárquica
Cidade → Região → Linha → Viagens.
## Operações sugeridas
atraso médio; linha mais atrasada; total de passageiros; viagens críticas;
regularidade por região.

### checklist do que deve ser feito no trabalho

 ### Checklist do que deve ser feito
 
 - [x] **F1 – Criação e Validação**
   * **O que fazer:** Criar uma função que recebe os dados "crus" para montar uma `Viagem`. Ela deve verificar pelo menos 3 regras de negócio e retornar um tipo `Result` (Ok com a Viagem, ou Error se algo estiver errado).
   * **Foi feito** Verificar se o id, tempo_previsto e tempo_realizado são maiores que 0. Isso em um tipo Opaque
   * [] **Se quiser adicionar** Uma validação que não permite adicionar viagens com id já existentes em uma linhas
 
 - [ ] **F2 – Classificação**
   * **O que fazer:** Criar uma função que recebe um registro válido e, usando `case` (pattern matching), classifica esse registro em pelo menos três categorias (um Tipo Soma que você deve criar).
   * **Sugestão Tema 9:** Criar um tipo `NivelAtraso` (`NoPrazo`, `AtrasoToleravel`, `AtrasoGrave`). A função calcula `tempo_realizado - tempo_previsto` e usa o `case` para retornar a categoria certa.
 
 - [ ] **F3 – Agregação sobre lista**
   * **O que fazer:** Usar *recursão estrutural manual* para percorrer uma lista de registros e calcular um valor único. **Proibido usar map/reduce/fold/funções prontas**.
   * **Sugestão Tema 9:** Calcular o **total de passageiros** transportados em uma lista de viagens. (Caso base: lista vazia = 0; Caso recursivo: soma o primeiro com a chamada recursiva do resto).
 
 - [ ] **F4 – Filtragem recursiva**
   * **O que fazer:** Receber uma lista e retornar uma *nova lista* apenas com os elementos que passam em um teste lógico. *Recursão manual.*
   * **Sugestão Tema 9:** Filtrar a lista para devolver **apenas viagens feitas por Ônibus** (descartando Vans e Micro-ônibus), ou apenas viagens com situação "Crítica".
 
 - [ ] **F5 – Transformação recursiva**
   * **O que fazer:** Receber uma lista e retornar uma *nova lista* (modificada ou extraindo um dado de cada elemento), preservando a imutabilidade. *Recursão manual.*
   * **Sugestão Tema 9:** Receber uma `List(Viagem)` e devolver uma `List(Int)` contendo apenas a **quantidade de minutos de atraso** de cada viagem daquela lista.
 
 - [ ] **F6 – Busca**
   * **O que fazer:** Percorrer a lista recursivamente procurando um elemento específico. Deve usar o tipo `Option` (`Some(elemento)` se achar, `None` se não achar).
   * **Sugestão Tema 9:** Buscar uma **viagem específica pelo número do `id`**.
 
 - [ ] **F7 – Maior ou menor elemento**
   * **O que fazer:** Percorrer a lista recursivamente para achar o elemento de maior ou menor valor segundo algum critério.
   * **Sugestão Tema 9:** Encontrar a **viagem que teve o pior tempo de atraso** (o maior valor de atraso) ou a **viagem com o maior número de passageiros**.
 
 - [ ] **F8 – Análise combinada**
   * **O que fazer:** Resolver um problema mais complexo que exija compor pelo menos duas etapas (usar funções auxiliares).
   * **Sugestão Tema 9:** Calcular a **média de passageiros apenas dos Ônibus**. 
     * *Plano:* (1) Função que filtra só os ônibus. (2) Função que soma os passageiros dessa lista filtrada. (3) Função que conta o tamanho da lista. (4) Função principal que divide a soma pela quantidade.
 
 - [ ] **F9 – Processamento hierárquico**
   * **O que fazer:** Implementar **duas funções recursivas** que processem a sua estrutura em árvore (Cidade -> Região -> Linha -> Viagens).
   * **Sugestões Tema 9:** 
     * *Função 1:* Soma o total de passageiros do município inteiro (descendo a recursão de Cidade até as Viagens).
     * *Função 2:* Vasculha o município inteiro e devolve uma única lista com todas as viagens Críticas/Atrasadas de todas as regiões combinadas.
 
 - [ ] **F10 – Relatório textual**
   * **O que fazer:** Produzir uma `String` juntando textos e pelo menos três resultados de cálculos feitos pelas funções anteriores.
   * **Sugestão Tema 9:** Retornar uma string formatada: *"Relatório da Cidade: O sistema processou um total de [X] passageiros. A viagem com pior atraso foi a de ID [Y]. Detectamos [Z] viagens críticas hoje."* (Use `int.to_string` para converter os números para texto).

 ## CheckList final: 

- [x] **Escolhemos um dos 10 temas e informamos a escolha conforme solicitado.**
- [ ] **Implementamos as funcionalidades F1–F10.**
- [x] **Criamos pelo menos 2 tipos soma e 1 tipo autorreferente.**
- [ ] **Implementamos pelo menos 5 funções recursivas, sendo pelo menos 3 estruturais.**
- [ ] **Não substituímos as recursões obrigatórias por funções de alta ordem.**
- [x] **Incluímos pelo menos 3 validações específicas do tema.**
- [ ] **Testamos casos típicos, limites e casos de ausência/erro.**
- [ ] **Documentamos a função que utiliza um plano de solução.**
- [ ] **O README permite identificar claramente onde cada requisito foi implementado.**
- [ ] **Todos os integrantes conseguem explicar o modelo de dados e as principais funções.**
