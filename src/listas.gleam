import tipos.{
  type Linha,
  Linha,
  Atrasada,
  mostra_situacao,
  mostra_previsao,
  mostra_id,
  mostra_tempo_realizado
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

/// Busca recursivamente uma viagem específica de uma *linha* a partir de seu *id*
pub fn busca_viagem_id(linha: Linha, id: Int) -> Result(Viagem, Nil) {
  case linha.viagens {
    [] -> Error(Nil)
    [primeiro, ..] if primeiro.id == id -> Ok(primeiro)
    [_, ..resto] -> busca_viagem_id(Linha(linha.nome, resto), id)
  }
}

/// Devolve uma lista com apenas o tempo previsto de cada viagem de uma *linha*
pub fn previsoes(linha: Linha) -> List[Int] {
  case linha {
    Linha(_, []) -> []
    Linha(_, [primeiro, ..resto]) -> [mostra_previsao(primeiro), ..previsoes(Linha(linha.nome, resto))]
  }
}

// Busca recursivamente a viagem mais adiantada de uma *linha*
pub fn busca_viagem_tempo(
  linha: Linha,
  tempo_atual: Int,
  id: Int,
) -> Result(Viagem, Nil) {
  case linha.viagens {
    [] -> Error(Nil)
    [primeiro, ..resto] -> {
      let tempo_realizado = mostra_tempo_realizado(primeiro)
      let id_viagem = mostra_id(primeiro)
      let situacao = mostra_situacao(primeiro)

      case situacao == Adiantada && tempo_realizado < tempo_atual {
        True ->
          busca_viagem_tempo(
            Linha(linha.nome, resto),
            tempo_realizado,
            id_viagem,
          )
        False -> busca_viagem_tempo(Linha(linha.nome, resto), tempo_atual, id)
      }
    }
  }
}
