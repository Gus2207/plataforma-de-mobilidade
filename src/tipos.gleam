//import gleam/float
//import gleam/int
//import gleam/string
// import sgleam/check

// import validacao

/// AQUI DEVEM SER COLOCADOS APENAS OS TIPOS DE DADOS [LEMBRAR DE APAGAR ESSAS MENSAGENS DEPOIS]
/// Representa a situação de uma viagem
pub type Situacao {
  Adiantada
  Pontual
  Atrasada
}

/// Representa regiões de uma cidade
pub type RegiaoCidade {
  Centro
  Periferia
  ZonaResidencial
  ZonaComercial
  ZonaIndustrial
  ZonaRural
}

/// Representa um tipo de transporte, onde todos eles possuem uma quantidade máxima de passageiros
pub type Transporte {
  Van(max_passageiros: Int)
  MicroOnibus(max_passageiros: Int)
  Onibus(max_passageiros: Int)
}

/// Retorna a quantidade máxima de passageiros de um *trasporte*
pub fn capacidade_maxima(transporte: Transporte) -> Int {
  case transporte {
    Van(_) -> 20
    MicroOnibus(_) -> 30
    Onibus(_) -> 45
  }
}

/// Representa uma viagem que foi realizada, onde:
/// - id deve ser um inteiro maior que 0 e não devem existir viagens com o mesmo id
/// - transporte é representado pela estrutura *Transporte*
/// - tempo_previsto e tempo_realizado representam minutos, que uma viagem deve durar e quanto ela realmente durou,
/// respectivamente. Ambos devem ser inteiros maiores que 0
/// - situacação é representado pelo tipo enumerado *Situacao*
pub opaque type Viagem {
  Viagem(
    id: Int,
    transporte: Transporte,
    tempo_previsto: Int,
    tempo_realizado: Int,
    situacao: Situacao,
  )
}

/// Recebe a quantidade de tempo de uma viagem e a classifica em *Adiantado*,
/// *Pontual*, *Atrasado*, *Cancelado*
pub fn classifica_tempo(
  tempo_previsto: Int,
  tempo_realizado: Int,
) -> Result(Situacao, Nil) {
  case tempo_previsto > 0 && tempo_realizado > 0 {
    True ->
      case tempo_previsto < tempo_realizado {
        True -> Ok(Adiantada)
        False ->
          case tempo_previsto == tempo_realizado {
            True -> Ok(Pontual)
            False -> Ok(Atrasada)
          }
      }
    False -> Error(Nil)
  }
}

/// Retorna ok(Viagem) se *id*, *tempo_previso* e *tempo_realizado* forem maiores que 0. Error(Nil) caso contrário.
/// Quanto aos paramentros *transporte*, *situação* não ha validações a serem realizadas.
pub fn cria_viagem(
  id: Int,
  transporte: Transporte,
  tempo_previsto: Int,
  tempo_realizado: Int,
) -> Result(Viagem, Nil) {
  let assert Ok(situacao) = classifica_tempo(tempo_previsto, tempo_realizado)
  case id > 0 && tempo_previsto > 0 && tempo_realizado > 0 {
    True ->
      Ok(Viagem(id, transporte, tempo_previsto, tempo_realizado, situacao))
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

/// Representa uma linha, que possui um nome especifico e uma listagem das viagens que foram realizadas nessa linha
pub type Linha {
  Linha(nome: String, viagens: List(Viagem))
}

/// Representa uma região com uma listagem das linhas de transporte
pub type Regiao {
  Regiao(regiao: RegiaoCidade, linhas: List(Linha))
}

/// Representa uma cidade com um nome próprio e uma listagem das regiões que existem nessa cidade
pub type Cidade {
  Cidade(nome: String, regioes: List(Regiao))
}

/// Faz o calculo do tempo médio realizado de viagens de uma linha inteira
pub fn percorre(linha: Linha) -> Int {
  case linha {
    Linha(_, []) -> 0
    Linha(_, [_, ..resto]) -> 1 + percorre(Linha(linha.nome, resto))
  }
}
