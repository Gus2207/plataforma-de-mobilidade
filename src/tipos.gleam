/// Representa a situação de uma viagem
pub type Situacao {
  Adiantada
  Pontual
  Atrasada
}

/// Representa um tipo de transporte
pub type Transporte {
  Van
  MicroOnibus
  Onibus
}

/// Representa uma viagem que foi realizada, onde:
/// - id deve ser um inteiro maior que 0
/// - tempo_previsto e tempo_realizado representam minutos que uma viagem deve durar e quanto ela realmente durou,
/// respectivamente. Ambos devem ser inteiros maiores que 0
pub opaque type Viagem {
  Viagem(
    id: Int,
    nome: String,
    transporte: Transporte,
    qtd_passageiros: Int,
    tempo_previsto: Int,
    tempo_realizado: Int,
    situacao: Situacao,
  )
}

/// Classifica uma viagem como:
/// Atrasada: caso *tempo_previsto* for menor que *tempo_realizado*
/// Pontual: caso *tempo_previsto* for igual a *tempo_realizado*
/// Adiantada: caso *tempo_previsto* for maior que *tempo_realizado*
pub fn classifica_tempo(
  tempo_previsto: Int,
  tempo_realizado: Int,
) -> Situacao{
  case tempo_previsto < tempo_realizado {
    True -> Atrasada
    False ->
      case tempo_previsto == tempo_realizado {
        True -> Pontual
        False -> Adiantada
      }
  }
}

/// Indica o transporte que deverá ser utilizado em uma viagem, sendo:
/// Van: caso a *qtd_passageitos* seja menor ou igual a 20
/// Onibus: caso a *qtd_passageiros* seja maior que 30
/// MicroOnibus: caso a *qtd_passageiros* seja maior que 20 e menor ou igual a 30
pub fn classifica_transporte(qtd_passageiros: Int) -> Transporte {
  case qtd_passageiros <= 20 {
    True -> Van
    False -> case qtd_passageiros > 30 {
      True -> Onibus
      False -> MicroOnibus
    }
  }
}

/// Retorna ok(Viagem) com um *nome* mas se *id*, *qtd_passageiros*, *tempo_previso* e *tempo_realizado*forem maiores que 0.
/// Error(Nil) caso contrário.
pub fn cria_viagem(
  id: Int,
  nome: String,
  qtd_passageiros: Int,
  tempo_previsto: Int,
  tempo_realizado: Int,
) -> Result(Viagem, Nil) {
  case id > 0 && tempo_previsto > 0 && tempo_realizado > 0 && qtd_passageiros > 0{
    True -> {
      let situacao = classifica_tempo(tempo_previsto, tempo_realizado)
      let transporte = classifica_transporte(qtd_passageiros)
      Ok(Viagem(id, nome, transporte, qtd_passageiros, tempo_previsto, tempo_realizado, situacao))
    }
    False -> Error(Nil)
  }
}

/// Devolve o valor do id de uma *viagem*
pub fn mostra_id(viagem: Viagem) {
  viagem.id
}

/// Devolve o valor do transporte de uma *viagem*
pub fn mostra_transporte(viagem: Viagem) {
  viagem.transporte
}

/// Devolve o valor do tempo_previsto de uma *viagem*
pub fn mostra_previsao(viagem: Viagem) {
  viagem.tempo_previsto
}

/// Devolve o valor do tempo_realizado de uma *viagem*
pub fn mostra_tempo_realizado(viagem: Viagem) {
  viagem.tempo_realizado
}

/// Devolve o valor da situacao de uma *viagem*
pub fn mostra_situacao(viagem: Viagem) {
  viagem.situacao
}

/// Devolve o valor do nome de uma *viagem*
pub fn mostra_nome(viagem: Viagem) {
  viagem.nome
}

/// Devolve o valor da qtd_passageiros de uma *viagem*
pub fn mostra_qtd_passageiros(viagem: Viagem) {
  viagem.qtd_passageiros
}

/// Representa uma linha, que possui um nome especifico e uma listagem das viagens que foram realizadas nessa linha
pub type Linha {
  Linha(nome: String, viagens: List(Viagem))
}

/// Representa uma região com uma listagem das linhas de transporte
pub type Regiao {
  Regiao(nome: String, sub_regioes: List(Regiao), linhas: List(Linha))
}

/// Representa uma cidade com um nome próprio e uma listagem das regiões que existem nessa cidade
pub type Cidade {
  Cidade(nome: String, regioes: List(Regiao))
}
