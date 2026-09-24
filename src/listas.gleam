import tipos.{
  type Linha,
  type Viagem,
  Linha,
  Atrasada,
  Adiantada,
  mostra_situacao,
  mostra_previsao,
  mostra_id,
  mostra_tempo_realizado
}

/// COLOCAR AQUI AS FUNÇÕES QUE MANUPULAM AS LISTAS DIRETAMENTE (F3 até F7)
/// Verifica quantas viagens foram realizadas em uma *linha* especifica
pub fn conta_elementos(linha: Linha) -> Int {
  case linha.viagens {
    [] -> 0
    [_, ..resto] -> 1 + conta_elementos(Linha(linha.nome, resto))
  }
}

/// Remove de uma Linha *linha* todas as viagens que estão atrasadas
pub fn viagens_pontuais(linha: Linha) -> Linha{
  case linha.viagens {
    [] -> Linha(linha.nome, [])
    [primeiro, ..resto] ->  case mostra_situacao(primeiro) == Atrasada {
      True -> viagens_pontuais(Linha(linha.nome, resto))
      False -> Linha(linha.nome, [primeiro, ..viagens_pontuais(Linha(linha.nome, resto)).viagens])
    }
  }
}

/// Busca recursivamente uma viagem específica de uma *linha* a partir de seu *id*
pub fn busca_viagem_id(linha: Linha, id: Int) -> Option(Viagem) {
  case linha.viagens {
    [] -> None
    [primeiro, ..resto] -> case mostra_id(primeiro) == id {
        True -> Some(primeiro)
        False ->busca_viagem_id(Linha(linha.nome, resto), id)
      }
  }
}

/// Devolve uma lista com apenas o tempo previsto de cada viagem de uma *linha*
pub fn previsoes(linha: Linha) -> List(Int) {
  case linha.viagens {
    [] -> []
    [primeiro, ..resto] -> [mostra_previsao(primeiro), ..previsoes(Linha(linha.nome, resto))]
  }
}

// Busca recursivamente a viagem mais adiantada de uma *linha*
pub fn busca_viagem_adiantada(linha: Linha) -> Option(Viagem){
  case linha.viagens {
    [] -> None
    [primeiro, ..resto] -> {
      let situacao_atual = mostra_situacao(primeiro)
      let melhor_resto = busca_viagem_adiantada(Linha(linha.nome, resto))

      case situacao_atual == Adiantada {
        True -> case melhor_resto {
          None -> Some(primeiro)
          Some(melhor_do_resto) -> case mostra_tempo_realizado(primeiro) > mostra_tempo_realizado(melhor_do_resto){
            True -> Some(melhor_do_resto)
            False -> Some(primeiro)
          }
        }
        False -> melhor_resto
      }
    }
  }
}
