import sgleam/check
import analise.{informacoes_linha, media_tempo, soma_tempo_realizado}
import tipos.{
  Adiantada,
  Atrasada,
  Linha,
  MicroOnibus,
  Onibus,
  Pontual,
  Van,
  cria_viagem,
  mostra_situacao,
  mostra_transporte,
}

/// TESTES DOS LIMITES DE CLASSIFICAÇAO DE TRANSPORTE

pub fn classifica_transporte_limites_examples() {
  ///
  let assert Ok(v_van) = cria_viagem(1, "V1", 20, 10, 10)
  check.eq(mostra_transporte(v_van), Van)

  let assert Ok(v_micro1) = cria_viagem(2, "V2", 21, 10, 10)
  let assert Ok(v_micro2) = cria_viagem(3, "V3", 30, 10, 10)
  check.eq(mostra_transporte(v_micro1), MicroOnibus)
  check.eq(mostra_transporte(v_micro2), MicroOnibus)

  let assert Ok(v_onibus) = cria_viagem(4, "V4", 31, 10, 10)
  check.eq(mostra_transporte(v_onibus), Onibus)
}

///TESTES DOS LIMITES DE SITUAÇÃO DA VIAGEM

pub fn classifica_tempo_situacoes_examples() {
  let assert Ok(v_atrasada) = cria_viagem(1, "V1", 10, 20, 25)
  check.eq(mostra_situacao(v_atrasada), Atrasada)

  let assert Ok(v_pontual) = cria_viagem(2, "V2", 10, 20, 20)
  check.eq(mostra_situacao(v_pontual), Pontual)

  let assert Ok(v_adiantada) = cria_viagem(3, "V3", 10, 25, 20)
  check.eq(mostra_situacao(v_adiantada), Adiantada)
}

/// TESTES: soma_tempo_realizado

pub fn soma_tempo_realizado_linha_vazia_examples() {
  let linha = Linha("Linha 101", [])
  check.eq(soma_tempo_realizado(linha), 0)
}

pub fn soma_tempo_realizado_com_viagens_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 25, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 35, 50, 40)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(soma_tempo_realizado(linha), 60)
}

///TESTES: media_tempo

pub fn media_tempo_linha_vazia_examples() {
  let linha = Linha("Linha 101", [])
  check.eq(media_tempo(linha), 0.0)
}

pub fn media_tempo_com_viagens_inteira_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 25, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 35, 50, 40)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(media_tempo(linha), 30.0)
}

pub fn media_tempo_decimal_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 15)
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 20, 20)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(media_tempo(linha), 17.5)
}

/// TESTES: informacoes_linha

pub fn informacoes_linha_vazia_examples() {
  let linha = Linha("Linha Expressa", [])

  let resultado = informacoes_linha(linha)
  let esperado =
    "A linha Linha Expressa não realizou nenhuma viagem até o presente momento."

  check.eq(resultado, esperado)
}

pub fn informacoes_linha_sem_viagem_adiantada_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 25, 20, 20)
  let linha = Linha("Linha Central", [v1])

  let resultado = informacoes_linha(linha)
  let esperado =
    "A linha Linha Central teve um total de 1 viagens.
        Com um tempo medio de realização de 20.0. Esta linha não possui viagens adiatandas"

  check.eq(resultado, esperado)
}

pub fn informacoes_linha_com_viagem_adiantada_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 25, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 35, 50, 40)
  let linha = Linha("Linha Norte", [v1, v2])

  let resultado = informacoes_linha(linha)
  let esperado =
    "A linha Linha Norte teve um total de 2 viagens. Com um tempo medio de realização de 30.0 e sua viagem mais adiantada foi V2."

  check.eq(resultado, esperado)
}
