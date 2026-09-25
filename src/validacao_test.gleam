import sgleam/check
import tipos.{
  Adiantada,
  Atrasada,
  MicroOnibus,
  Onibus,
  Pontual,
  Van,
  classifica_tempo,
  classifica_transporte,
  cria_viagem,
  mostra_id,
  mostra_nome,
  mostra_previsao,
  mostra_qtd_passageiros,
  mostra_situacao,
  mostra_tempo_realizado,
  mostra_transporte,
}

/// TESTES DE CRIAÇAO COM SUCESSO

pub fn cria_viagem_sucesso_van_examples() {
  let assert Ok(viagem) = cria_viagem(1, "Linha Van", 15, 20, 20)
  check.eq(mostra_transporte(viagem), Van)
}

pub fn cria_viagem_sucesso_micro_onibus_examples() {
  let assert Ok(viagem) = cria_viagem(2, "Linha Micro", 25, 30, 25)
  check.eq(mostra_transporte(viagem), MicroOnibus)
}

pub fn cria_viagem_sucesso_onibus_examples() {
  // 35 está dentro da faixa de Ônibus (31 a 40)
  let assert Ok(viagem) = cria_viagem(3, "Linha Onibus", 35, 40, 45)
  check.eq(mostra_transporte(viagem), Onibus)
}

/// TESTES DE VALIDAÇÃO E ERROS DE ENTRADA (cria_viagem)

pub fn cria_viagem_id_invalido_examples() {
  check.eq(cria_viagem(0, "V1", 20, 10, 10), Error(Nil))
  check.eq(cria_viagem(-1, "V1", 20, 10, 10), Error(Nil))
}

pub fn cria_viagem_passageiros_invalidos_examples() {
  // Quantidade zero ou negativa
  check.eq(cria_viagem(1, "V1", 0, 10, 10), Error(Nil))
  check.eq(cria_viagem(1, "V1", -5, 10, 10), Error(Nil))

  // Acima do limite máximo permitido (41 passageiros)
  check.eq(cria_viagem(1, "V1", 41, 10, 10), Error(Nil))
}

pub fn cria_viagem_tempos_invalidos_examples() {
  // Tempo previsto inválido
  check.eq(cria_viagem(1, "V1", 20, 0, 10), Error(Nil))
  check.eq(cria_viagem(1, "V1", 20, -10, 10), Error(Nil))

  // Tempo realizado inválido
  check.eq(cria_viagem(1, "V1", 20, 10, 0), Error(Nil))
  check.eq(cria_viagem(1, "V1", 20, 10, -5), Error(Nil))
}

/// TESTES DE CLASSIFICAÇÃO DE TRANSPORTE E SITUAÇAO

pub fn classifica_transporte_examples() {
  check.eq(classifica_transporte(15), Van)
  check.eq(classifica_transporte(20), Van)
  check.eq(classifica_transporte(21), MicroOnibus)
  check.eq(classifica_transporte(30), MicroOnibus)
  check.eq(classifica_transporte(31), Onibus)
  check.eq(classifica_transporte(40), Onibus)
}

pub fn classifica_tempo_examples() {
  check.eq(classifica_tempo(20, 25), Atrasada)
  check.eq(classifica_tempo(20, 20), Pontual)
  check.eq(classifica_tempo(25, 20), Adiantada)
}

/// TESTES DAS FUNÇÕES DE RESGATE DE VALORES

pub fn mostra_campos_viagem_examples() {
  let assert Ok(viagem) = cria_viagem(10, "Expressa 01", 35, 45, 40)

  check.eq(mostra_id(viagem), 10)
  check.eq(mostra_nome(viagem), "Expressa 01")
  check.eq(mostra_qtd_passageiros(viagem), 35)
  check.eq(mostra_previsao(viagem), 45)
  check.eq(mostra_tempo_realizado(viagem), 40)
  check.eq(mostra_transporte(viagem), Onibus)
  check.eq(mostra_situacao(viagem), Adiantada)
}
