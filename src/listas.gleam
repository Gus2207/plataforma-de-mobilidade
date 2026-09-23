import tipos.{
  type Linha,
  Linha,
  Atrasada,
  mostra_situacao,
  mostra_previsao,
}

/// COLOCAR AQUI AS FUNÇÕES QUE MANUPULAM AS LISTAS DIRETAMENTE (F3 até F7)
/// Verifica quantas viagens foram realizadas em uma *linha* especifica
pub fn conta_elementos(linha: Linha) -> Int {
  case linha {
    Linha(_, []) -> 0
    Linha(_, [_, ..resto]) -> 1 + conta_elementos(Linha(linha.nome, resto))
  }
}

/// Remove de uma lista de Linhas *linha* todas as viagens que estão atrasadas
pub fn viagens_pontuais(linha: Linha) -> Linha{
  case linha {
    Linha(_, []) -> Linha(linha.nome, [])
    Linha(_, [primeiro, ..resto]) ->  case mostra_situacao(primeiro) == Atrasada {
      True -> viagens_pontuais(Linha(linha.nome, resto))
      False -> Linha(linha.nome, [primeiro, ..viagens_pontuais(Linha(linha.nome, resto)).viagens])
    }
  }
}

/// Devolve uma lista com apenas o tempo previsto de cada viagem de uma *linha*
pub fn previsoes(linha: Linha) -> List[Int] {
  case linha {
    Linha(_, []) -> []
    Linha(_, [primeiro, ..resto]) -> [mostra_previsao(primeiro), ..previsoes(Linha(linha.nome, resto))]
  }
}
