/// COLOCAR AQUI AS FUNÇÕES QUE MANUPULAM AS LISTAS DIRETAMENTE (F3 até F7)
/// Busca recursivamente uma viagem específica de uma *linha* a partir de seu *id*
pub fn busca_viagem_id(linha: Linha, id: Int) -> Result(Viagem, Nil) {
  case linha.viagens {
    [] -> Error(Nil)
    [primeiro, ..] if primeiro.id == id -> Ok(primeiro)
    [_, ..resto] -> busca_viagem_id(Linha(linha.nome, resto), id)
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
