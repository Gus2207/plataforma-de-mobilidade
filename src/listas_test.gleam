import gleam/option.{None, Some}
import sgleam/check
import listas.{
  busca_viagem_adiantada,
  busca_viagem_id,
  conta_elementos,
  filtra_nao_atrasadas,
  previsoes_viagem,
  quantidade_viagens,
  viagens_pontuais,
}
import tipos.{Linha, cria_viagem}

/// TESTES: conta_elementos / quantidade_viagens

pub fn conta_elementos_vazia_examples() {
  check.eq(conta_elementos([]), 0)
}

pub fn quantidade_viagens_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 15, 30, 25)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(quantidade_viagens(linha), 2)
}

/// TESTES: filtra_nao_atrasadas / viagens_pontuais

pub fn filtra_nao_atrasadas_vazia_examples() {
  check.eq(filtra_nao_atrasadas([]), [])
}

pub fn filtra_nao_atrasadas_com_remocao_examples() {
  // v1 Pontual
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 20)
  // v2 Atrasada
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 20, 25)
  // v3 Adiantada
  let assert Ok(v3) = cria_viagem(3, "V3", 10, 25, 20)

  let linha = Linha("Linha 101", [v1, v2, v3])
  let linha_filtrada = viagens_pontuais(linha)

  check.eq(linha_filtrada.viagens, [v1, v3])
}

/// TESTES: busca_elemento / busca_viagem_id

pub fn busca_viagem_id_vazio_examples() {
  let linha = Linha("Linha Vazia", [])
  check.eq(busca_viagem_id(linha, 1), None)
}

pub fn busca_viagem_id_encontrado_e_nao_encontrado_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 20, 20)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(busca_viagem_id(linha, 2), Some(v2))
  check.eq(busca_viagem_id(linha, 99), None)
}

/// TESTES: transforma_lista_viagens / previsoes_viagem

pub fn previsoes_viagem_vazia_examples() {
  let linha = Linha("Linha Vazia", [])
  check.eq(previsoes_viagem(linha), [])
}

pub fn previsoes_viagem_com_elementos_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 15, 15)
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 40, 35)
  let linha = Linha("Linha 101", [v1, v2])
  check.eq(previsoes_viagem(linha), [15, 40])
}

/// TESTES: viagem_adiantada / busca_viagem_adiantada

pub fn busca_viagem_adiantada_vazia_examples() {
  let linha = Linha("Linha Vazia", [])
  check.eq(busca_viagem_adiantada(linha), None)
}

pub fn busca_viagem_adiantada_sem_adiantadas_examples() {
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 20)
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 20, 25)
  let linha = Linha("Linha 101", [v1, v2])

  check.eq(busca_viagem_adiantada(linha), None)
}

pub fn busca_viagem_adiantada_mais_rapida_examples() {
  // v1: Adiantada tempo_realizado = 15
  let assert Ok(v1) = cria_viagem(1, "V1", 10, 20, 15)
  // v2: Adiantada tempo_realizado = 10 (tem que escolhe esse por ser o menor tempo)
  let assert Ok(v2) = cria_viagem(2, "V2", 10, 20, 10)
  // v3: Atrasada tempo_realizado = 25
  let assert Ok(v3) = cria_viagem(3, "V3", 10, 20, 25)

  let linha = Linha("Linha 101", [v1, v2, v3])
  check.eq(busca_viagem_adiantada(linha), Some(v2))
}
