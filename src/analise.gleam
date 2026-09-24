import gleam/int
import tipos.{
  type Linha,
  Linha,
  mostra_tempo_realizado,
  mostra_nome,
}
import listas.{
  conta_elementos,
  busca_viagem_tempo,
}
/// AQUI COLOCAR LÓGICAS MAIS COMPLEXAS (F8 e 10 por exemplo)

/// Soma todos os tempos realizados das viagens de uma linha
pub fn soma_tempo_realizado(linha: Linha) -> Int{
  case linha {
    Linha(_, []) -> 0
    Linha(_, [primeiro, ..resto]) -> mostra_tempo_realizado(primeiro) + soma_tempo_realizado(Linha(linha.nome, resto))
  }
}

/// Calcula a media do tempo realizado das viagens de uma linha
pub fn media_tempo(linha: Linha) -> Float {
  let qtd_viagens = int.to_float(conta_elementos(linha))
  let soma_tempo_realizado = int.to_float(soma_tempo_realizado(linha))
  soma_tempo_realizado /. qtd_viagens
}

/// Informa o tempo médio de viagens de uma linha, qual a viagem mais adiantada
/// e o total de viagens realizadas por aquela linha.
pub fn informacoes_linha(linha: Linha) -> String {
  let total_viagens = int.to_string(conta_elementos(linha))
  let tempo_medio = int.to_string(media_tempo(linha))
  let viagem_adiantada = mostra_nome(busca_viagem_tempo(linha, 0, 0))

  "A linha " <> linha.nome <> " teve um total de " <> total_viagens <> " viagens. Com um tempo medio de realização de "
  <> tempo_medio <> " e sua viagem mais adiantada foi " <> viagem_adiantada <> "."
}
