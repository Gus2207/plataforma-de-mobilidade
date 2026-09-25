import gleam/int
import gleam/float
import gleam/option.{Some, None}
import tipos.{
  type Linha,
  Linha,
  mostra_tempo_realizado,
  mostra_nome,
}
import listas.{
  conta_elementos,
  busca_viagem_adiantada,
}
/// AQUI COLOCAR LÓGICAS MAIS COMPLEXAS (F8 e 10 por exemplo)

/// Soma todos os tempos realizados das viagens de uma linha
pub fn soma_tempo_realizado(linha: Linha) -> Int{
  case linha.viagens {
    [] -> 0
    [primeiro, ..resto] -> mostra_tempo_realizado(primeiro) + soma_tempo_realizado(Linha(linha.nome, resto))
  }
}

/// Calcula a media do tempo realizado das viagens de uma linha
pub fn media_tempo(linha: Linha) -> Float {
  let qtd_viagens = int.to_float(conta_elementos(linha.viagens))
  let soma_tempo_realizado = int.to_float(soma_tempo_realizado(linha))

  case qtd_viagens == 0.0 {
    True -> 0.0
    False -> soma_tempo_realizado /. qtd_viagens
  }
}

/// Informa o tempo médio de viagens de uma linha, qual a viagem mais adiantada
/// e o total de viagens realizadas por aquela linha.
pub fn informacoes_linha(linha: Linha) -> String {
  let total_viagens = conta_elementos(linha.viagens)

  case total_viagens == 0{
    True -> "A linha " <> linha.nome <> " não realizou nenhuma viagem até o presente momento."
    False -> {
      let tempo_medio = float.to_string(media_tempo(linha))
      let viagem_adiantada = busca_viagem_adiantada(linha)
      case viagem_adiantada {
        None -> "A linha " <> linha.nome <> " teve um total de " <> int.to_string(total_viagens) <> " viagens.
        Com um tempo medio de realização de "
        <> tempo_medio <> ". Esta linha não possui viagens adiatandas"
        Some(adiantada) -> "A linha " <> linha.nome <> " teve um total de " <> int.to_string(total_viagens) <>
        " viagens. Com um tempo medio de realização de "
        <> tempo_medio <> " e sua viagem mais adiantada foi " <> mostra_nome(adiantada) <> "."
      }
    }
  }
}
