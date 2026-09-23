/// AQUI EXCLUSIVO PARA ABRIGAR A MANUPULAÇÃO DA HIERARQUIA F9

/// Funcao recursiva que processa de forma hierrquica todas as linhas da cidade
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
pub fn percorre_regiao(regioes: Regiao) -> Int {
  case regioes.linhas {
    [] -> 0
    [primeiro, ..resto] -> {
      let resultado = percorre_linhas(primeiro)
      resultado
      + percorre_regiao(Regiao(regioes.regiao, regioes.sub_regioes, resto))
      + percorre_sub_regioes(regioes.sub_regioes)
    }
  }
}

/// funcao recursiva que percorre uma lista de regioes (sub regioes de uma
///regiao) e chama a percorre_regiao para percorrer a regiao dessa lista
pub fn percorre_sub_regioes(subregioes: List(Regiao)) -> Int {
  case subregioes {
    [] -> 0
    [primeiro, ..resto] -> {
      let resultado = percorre_regiao(primeiro)

      resultado + percorre_sub_regioes(resto)
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
        False -> 0 + percorre_linhas(Linha(linhas.nome, resto))
      }
    }
  }
}
