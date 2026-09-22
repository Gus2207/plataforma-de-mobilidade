import tipos

/// COLOCAR AQUI AS FUNÇÕES QUE MANUPULAM AS LISTAS DIRETAMENTE (F3 até F7)
/// Verifica quantas viagens foram realizadas em uma *linha* especifica
pub fn percorre(linha: Linha) -> Int {
  case linha {
    Linha(_, []) -> 0
    Linha(_, [_, ..resto]) -> 1 + percorre(Linha(linha.nome, resto))
  }
}

/// Remove de uma lista de Linhas *linha* todas as viagens que estão atrasadas
pub fn viagens_pontuais(linha: Linha) -> Linha{
  case linha {
    Linha(_, []) -> Linha[linha.nome, []]
    Linha(_, [primeiro, ..resto]) ->  case primeiro.situacao == Atrasada {
      True -> viagens_pontuais(Linha(linha.nome, [resto]))
      False -> Linha(linha.nome, [primeiro, ..viagens_pontuais(Linha.nome, [resto]]))
    }
  }
}
