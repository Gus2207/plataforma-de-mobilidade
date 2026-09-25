import sgleam/check
import hierarquia.{busca_viagens_onibus, busca_viagens_totais}
import tipos.{Cidade, Linha, Regiao, cria_viagem}

/// TESTES DE ESTRUTURAS VAZIAS

pub fn hierarquia_cidade_vazia_examples() {
  let cidade = Cidade("Cidade Vazia", [])

  check.eq(busca_viagens_onibus(cidade), 0)
  check.eq(busca_viagens_totais(cidade), 0)
}

pub fn hierarquia_regiao_sem_linhas_e_subregioes_examples() {
  let regiao = Regiao("Centro", [], [])
  let cidade = Cidade("Cidade Teste", [regiao])

  check.eq(busca_viagens_onibus(cidade), 0)
  check.eq(busca_viagens_totais(cidade), 0)
}

/// TESTES DE HIERARQUIA PLANA (1 Nível de Região com Transportes Misto)

pub fn hierarquia_plana_transportes_mistos_examples() {
  // 1 Van (15 pass)
  let assert Ok(v_van) = cria_viagem(1, "V1", 15, 20, 20)
  // 1 Micro-ônibus (25 pass)
  let assert Ok(v_micro) = cria_viagem(2, "V2", 25, 20, 20)
  // 2 Ônibus (35 e 32 pass)
  let assert Ok(v_onibus1) = cria_viagem(3, "V3", 35, 20, 20)
  let assert Ok(v_onibus2) = cria_viagem(4, "V4", 32, 20, 20)

  let linha1 = Linha("Linha 1", [v_van, v_micro])
  let linha2 = Linha("Linha 2", [v_onibus1, v_onibus2])

  let regiao = Regiao("Zona Sul", [], [linha1, linha2])
  let cidade = Cidade("Metrópole", [regiao])

  check.eq(busca_viagens_totais(cidade), 4)
  check.eq(busca_viagens_onibus(cidade), 2)
}

/// TESTES DE HIERARQUIA RECURSIVA (Sub-regiões Aninhadas)

pub fn hierarquia_sub_regioes_aninhadas_examples() {
  // Nviel 3: 1 viagem de Ônibus
  let assert Ok(v_onibus_profundo) = cria_viagem(1, "V1", 35, 30, 30)
  let linha_profunda = Linha("Linha Bairro Distante", [v_onibus_profundo])
  let sub_sub_regiao = Regiao("Vila Distante", [], [linha_profunda])

  // Nivel 2: 1 viagem de Van + Sub-sub-região
  let assert Ok(v_van) = cria_viagem(2, "V2", 10, 15, 15)
  let linha_sub = Linha("Linha Local", [v_van])
  let sub_regiao = Regiao("Bairro Central", [sub_sub_regiao], [linha_sub])

  // Nivel 1: 1 viagem de Ônibus + Sub-região
  let assert Ok(v_onibus_principal) = cria_viagem(3, "V3", 40, 50, 50)
  let linha_principal = Linha("Linha Expressa", [v_onibus_principal])
  let regiao_principal = Regiao("Zona Norte", [sub_regiao], [linha_principal])

  let cidade = Cidade("Capital", [regiao_principal])

  // total de viagens acumuladas nos 3: 1 + 1 + 1 = 3
  check.eq(busca_viagens_totais(cidade), 3)

  // viagens de onibus acumuladas nos 3: 1 (nivel 3) + 0 (nivel 2) + 1 (nivel 1) = 2
  check.eq(busca_viagens_onibus(cidade), 2)
}

/// TESTES COM MULTIPLAS REGIOES NA MESMA CIDADE

pub fn hierarquia_multiplas_regioes_examples() {
  let assert Ok(v_onibus1) = cria_viagem(1, "V1", 31, 20, 20)
  let assert Ok(v_onibus2) = cria_viagem(2, "V2", 38, 20, 20)

  let regiao1 = Regiao("Região A", [], [Linha("L1", [v_onibus1])])
  let regiao2 = Regiao("Região B", [], [Linha("L2", [v_onibus2])])

  let cidade = Cidade("Cidade Grande", [regiao1, regiao2])

  check.eq(busca_viagens_totais(cidade), 2)
  check.eq(busca_viagens_onibus(cidade), 2)
}
