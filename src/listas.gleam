/// COLOCAR AQUI AS FUNÇÕES QUE MANUPULAM AS LISTAS DIRETAMENTE (F3 até F7)
/// Verifica quantas viagens foram realizadas em uma *linha* especifica
pub fn percorre(linha: Linha) -> Int {
  case linha {
    Linha(_, []) -> 0
    Linha(_, [_, ..resto]) -> 1 + percorre(Linha(linha.nome, resto))
  }
}

/// Remove de uma lista
