import gleam/option.{type Option, None, Some}
import tipos.{
  type Linha,
  type Viagem,
  Adiantada,
  Atrasada,
  Linha,
  mostra_id,
  mostra_previsao,
  mostra_situacao,
  mostra_tempo_realizado,
}

/// Conta quantas viagens foram realizadas em uma *linha* especifica
pub fn quantidade_viagens(linha: Linha) -> Int {
  conta_elementos(linha.viagens)
}

/// Retorna quantos elementos *viagens* possui
pub fn conta_elementos(viagens: List(Viagem)) -> Int {
  case viagens {
    [] -> 0
    [_, ..resto] -> 1 + conta_elementos(resto)
  }
}

/// Retorna uma nova linha de viagens com apenas viagens classificadas como Adiantada ou Pontuais
pub fn viagens_pontuais(linha: Linha) -> Linha {
  Linha(linha.nome, filtra_nao_atrasadas(linha.viagens))
}

/// Cria uma nova List de Viagem a partir de *viagens* sem os elementos classificados como Atrasada.
pub fn filtra_nao_atrasadas(viagens: List(Viagem)) -> List(Viagem) {
  case viagens {
    [] -> []
    [primeiro, ..resto] ->
      case mostra_situacao(primeiro) == Atrasada {
        True -> filtra_nao_atrasadas(resto)
        False -> [primeiro, ..filtra_nao_atrasadas(resto)]
      }
  }
}

/// Busca uma viagem específica de uma *linha* a partir de seu *id*
pub fn busca_viagem_id(linha: Linha, id: Int) -> Option(Viagem) {
  busca_elemento(linha.viagens, id)
}

/// Busca recursivamente uma viagem específica de uma lista de viagens a partir de seu *id*
pub fn busca_elemento(viagens: List(Viagem), id: Int) -> Option(Viagem) {
  case viagens {
    [] -> None
    [primeiro, ..resto] ->
      case mostra_id(primeiro) == id {
        True -> Some(primeiro)
        False -> busca_elemento(resto, id)
      }
  }
}

/// Devolve uma lista com apenas o tempo previsto de cada viagem de uma *linha*
pub fn previsoes_viagem(linha: Linha) -> List(Int) {
  transforma_lista_viagens(linha.viagens)
}

/// Transforma uma List Viagem em um List Int extraindo a *mostra_previsao* de cada elemento
pub fn transforma_lista_viagens(viagens: List(Viagem)) -> List(Int) {
  case viagens {
    [] -> []
    [primeiro, ..resto] -> [
      mostra_previsao(primeiro),
      ..transforma_lista_viagens(resto)
    ]
  }
}

/// Busca recursivamente a viagem mais adiantada de uma *linha*
pub fn busca_viagem_adiantada(linha: Linha) -> Option(Viagem) {
  viagem_adiantada(linha.viagens)
}

/// Busca recursivamente a viagem mais adiantada de uma lista de viagens
pub fn viagem_adiantada(viagens: List(Viagem)) -> Option(Viagem) {
  case viagens {
    [] -> None
    [primeiro, ..resto] -> {
      let situacao_atual = mostra_situacao(primeiro)
      let melhor_resto = viagem_adiantada(resto)

      case situacao_atual == Adiantada {
        True ->
          case melhor_resto {
            None -> Some(primeiro)
            Some(melhor_do_resto) ->
              case
                mostra_tempo_realizado(primeiro)
                > mostra_tempo_realizado(melhor_do_resto)
              {
                True -> Some(melhor_do_resto)
                False -> Some(primeiro)
              }
          }
        False -> melhor_resto
      }
    }
  }
}
