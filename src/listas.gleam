import gleam/option.{type Option, Some, None}

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

/// Conta quantas viagens foram realizadas em uma *linha* especifica, utilizando a função *conta_elementos*
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

/// Retorna uma nova linha de viagens com apenas viagens classificadas como Adiantada ou Pontuais a partir de uma *linha*,
/// utilizando a função *filta_nao_atrasadas*
pub fn viagens_pontuais(linha: Linha) -> Linha{
  Linha(linha.nome, filtra_nao_atrasadas(linha.viagens))
}

/// Cira uma nova List de Viagem a partir de *viagens* sem os elementos classificados como Atrasada.
pub fn filtra_nao_atrasadas(viagens: List(Viagem)) -> List(Viagem){
  case viagens {
    [] -> []
    [primeiro, ..resto] -> case mostra_situacao(primeiro) == Atrasada {
      True -> filtra_nao_atrasadas(resto)
      False -> [primeiro, ..filtra_nao_atrasadas(resto)]
    }
  }
}

/// Busca uma viagem específica de uma *linha* a partir de seu *id* utilizando a função *busca_elemento*
pub fn busca_viagem_id(linha: Linha, id: Int) -> Option(Viagem){
  busca_elemento(linha.viagens, id)
}

/// Busca recursivamente uma viagem específica de uma *linha* a partir de seu *id*
pub fn busca_elemento(viagens: List(Viagem), id: Int) -> Option(Viagem) {
  case linha.viagens {
    [] -> None
    [primeiro, ..resto] -> case mostra_id(primeiro) == id {
        True -> Some(primeiro)
        False ->busca_viagem_id(resto, id)
      }
  }
}

/// Devolve uma lista com apenas o tempo previsto de cada viagem de uma *linha*, utilizando a função *transforma_lista*
pub fn previsoes_viagem(linha: Linha) -> List(Int) {
  transforma_lista_viagens(linha.viagens)
}

/// Transforma um List Viagem *viagens* em um List Int extraindo a *mostra_previsao* de cada elemento
pub fn transforma_lista_viagens(viagens: List(Viagem)) -> List(Int) {
  case viagens {
    [] -> []
    [primeiro, ..resto] -> [mostra_previsao(primeiro), ..transforma_lista(resto)]
  }
}

// Busca recursivamente a viagem mais adiantada de uma *linha*, utilizando a função *viagem_adiantada*
pub fn busca_viagem_adiatanda(linha: Linha) -> Option(Viagem) {
  viagem_adiantada(linha.viagens)
}

// Busca recursivamente a viagem mais adiantada de uma List de Viagem *viagens*, isto é,
// o elemento com menor tempo_realizado e classficado como Adiantada
pub fn viagem_adianta(viagens: List(Viagem)) -> Option(Viagem){
  case viagens {
    [] -> None
    [primeiro, ..resto] -> {
      let situacao_atual = mostra_situacao(primeiro)
      let melhor_resto = busca_viagem_adiantada(resto)

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
