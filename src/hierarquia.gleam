import tipos.{
  type Cidade,
  type Linha,
  type Regiao,
  type Viagem,
  Onibus,
  mostra_transporte,
}

/// Função inicial de uma hierarquia que calcula a quantidade total de viagens de onibus de uma *cidade*
pub fn busca_viagens_onibus(cidade: Cidade) -> Int {
  percorre_regioes(cidade.regioes)
}

/// Funcao recursiva que percorre uma lista de Regiao *regioes* que podem ser regiões de uma cidade ou subregioes de uma regiao
/// e soma a quantidade de viagens realizadas de onibus na região utilizando a função *calcula_regiao*.
pub fn percorre_regioes(regioes: List(Regiao)) -> Int {
  case regioes {
    [] -> 0
    [primeiro, ..resto] -> {
      calcula_regiao(primeiro) + percorre_regioes(resto)
    }
  }
}

/// Soma a quantidade de viagens realizadas de onibus em uma *regiao* com a quantidade de viagens realizadas de onibus em suas subregioes,
/// utilizando as funções *percorre_lista_linhas* e *percorre_regioes*
pub fn calcula_regiao(regiao: Regiao) -> Int {
  percorre_lista_linhas(regiao.linhas) + percorre_regioes(regiao.sub_regioes)
}

/// Calcula a quantidade de viagens de onibus realizadas em um List de Linha *linha*, utilizando a função
/// *percorre_viagens_onibus*
pub fn percorre_lista_linhas(linhas: List(Linha)) -> Int {
  case linhas {
    [] -> 0
    [primeiro, ..resto] -> {
      percorre_viagens_onibus(primeiro.viagens) + percorre_lista_linhas(resto)
    }
  }
}

/// Calcula a quantidade de viagens realizadas de onibus em um List de Viagem *viagens*
pub fn percorre_viagens_onibus(viagens: List(Viagem)) -> Int {
  case viagens {
    [] -> 0
    [primeiro, ..resto] -> case mostra_transporte(primeiro) == Onibus {
      True -> 1 + percorre_viagens_onibus(resto)
      False -> percorre_viagens_onibus(resto)
    }
  }
}

// =============================================================================
// 2. TOTAL ABSOLUTO DE VIAGENS (TODOS OS TRANSPORTES)
// =============================================================================

/// Pega a hierarquia mais alta (*Cidade*) e percorre suas regioes, além de
/// fazer a chamada da funcao que percorre as linhas de uma regiao e a chamada
///da funcao que percorre as subregioes
pub fn busca_viagens_totais(cidade: Cidade) -> Int {
  percorre_sub_regioes_totais(cidade.regioes)
}

/// funcao recursiva que percorre uma lista de regioes (sub regioes de uma
///regiao) e chama a percorre_regiao para percorrer a regiao dessa lista
pub fn percorre_sub_regioes_totais(subregioes: List(Regiao)) -> Int {
  case subregioes {
    [] -> 0
    [primeiro, ..resto] -> {
      percorre_regiao_totais(primeiro) + percorre_sub_regioes_totais(resto)
    }
  }
}

/// Recebe UMA Região: Soma as viagens totais das suas linhas + sub-regiões
pub fn percorre_regiao_totais(regiao: Regiao) -> Int {
  percorre_lista_linhas_totais(regiao.linhas) + percorre_sub_regioes_totais(regiao.sub_regioes)
}

/// Percorre a lista de linhas de uma região para o total de viagens
pub fn percorre_lista_linhas_totais(linhas: List(Linha)) -> Int {
  case linhas {
    [] -> 0
    [primeiro, ..resto] -> {
      percorre_linhas_totais(primeiro) + percorre_lista_linhas_totais(resto)
    }
  }
}

/// Recebe UMA Linha: Pega a lista de viagens dela e conta todas
pub fn percorre_linhas_totais(linha: Linha) -> Int {
  percorre_viagens_totais(linha.viagens)
}

/// Percorre a lista de viagens (List(Viagem)) contando todas
pub fn percorre_viagens_totais(viagens: List(Viagem)) -> Int {
  case viagens {
    [] -> 0
    [_, ..resto] -> 1 + percorre_viagens_totais(resto)
  }
}
