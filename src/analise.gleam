import gleam/int
import tipos.{
  type Linha,
  Linha,
  mostra_tempo_realizado,
}
import listas.{
  conta_elementos
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

/// Verifica qual o meio de transporte mais
