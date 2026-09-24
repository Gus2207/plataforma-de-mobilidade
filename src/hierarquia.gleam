import tipos.{
  type Linha,
  type Regiao,
  type Cidade,
  Cidade,
  Regiao,
  Onibus,
  Linha,
  mostra_transporte,
}

/// AQUI EXCLUSIVO PARA ABRIGAR A MANUPULAÇÃO DA HIERARQUIA F9

/// Funcao recursiva que processa de forma hierarquica todas as linhas da cidade
/// que são de onibus, devolvendo no fim a quantidade de viagens de onibus
pub fn busca_viagens_onibus(cidade: Cidade) -> Int {
  case cidade.regioes {
    [] -> 0
    [primeiro, ..resto] -> {
      let resultado = percorre_regiao(primeiro)
      resultado + busca_viagens_onibus(Cidade(cidade.nome, resto))
    }
  }
}

/// Pega a hierarquia mais alta (*Cidade*) e percorre suas regioes, além de
// fazer a chamada da funcao que percorre as linhas de uma regiao e a chamada

///da funcao que percorre as subregioes
pub fn percorre_regiao(regiao: Regiao) -> Int {
  case regiao.linhas {
    [] -> percorre_sub_regioes(regiao.sub_regioes)
    [primeiro, ..resto] -> {
      let resultado = percorre_linhas(primeiro)
      resultado
      + percorre_regiao(Regiao(regiao.nome, regiao.sub_regioes, resto))
    }
  }
}

/// funcao recursiva que percorre uma lista de regioes (sub regioes de uma
///regiao) e chama a percorre_regiao para percorrer a regiao dessa lista
pub fn percorre_sub_regioes(subregioes: List(Regiao)) -> Int {
  case subregioes {
    [] -> percorre_sub_regioes(resto)
    [primeiro, ..resto] -> {
      let resultado = percorre_regiao(primeiro)
      resultado + percorre_regiao(resto)
    }
  }
}

/// funcao recursiva que recebe uma *linha*de uma região e verifica quantos
///transportes dessa linha são onibus
pub fn percorre_linhas(linhas: Linha) -> Int {
  case linhas.viagens {
    [] -> 0
    [primeiro, ..resto] -> {
      let transporte = mostra_transporte(primeiro)

      case transporte == Onibus {
        True -> 1 + percorre_linhas(Linha(linhas.nome, resto))
        False -> percorre_linhas(Linha(linhas.nome, resto))
      }
    }
  }
}

/// Pega a hierarquia mais alta (*Cidade*) e percorre suas regioes, além de
/// fazer a chamada da funcao que percorre as linhas de uma regiao e a chamada
///da funcao que percorre as subregioes
pub fn percorre_regiao_totais(regiao: Regiao) -> Int {
  case regiao.linhas {
    [] -> percorre_sub_regioes_totais(regiao.sub_regioes)
    [primeiro, ..resto] -> {
      let resultado = percorre_linhas_totais(primeiro)
      resultado
      + percorre_regiao_totais(Regiao(
        regiao.regiao,
        regiao.sub_regioes,
        resto,
      ))
    }
  }
}

/// funcao recursiva que percorre uma lista de regioes (sub regioes de uma
///regiao) e chama a percorre_regiao para percorrer a regiao dessa lista
pub fn percorre_sub_regioes_totais(subregioes: List(Regiao)) -> Int {
  case subregioes {
    [] -> percorre_sub_regioes_totais(resto)
    [primeiro, ..resto] -> {
      let resultado = percorre_regiao_totais(primeiro)
      resultado + percorre_regiao_totais(resto)
    }
  }
}

/// funcao recursiva que recebe uma *linha*de uma região e verifica quantos
///viagens tem em uma cidade
pub fn percorre_linhas_totais(linhas: Linha) -> Int {
  case linhas.viagens {
    [] -> 0
    [_, ..resto] -> {
      1 + percorre_linhas_totais(Linha(linhas.nome, resto))
    }
  }
}
