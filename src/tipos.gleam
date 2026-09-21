import sgleam/check
import gleam/int
import gleam/float
import gleam/string

/// AQUI DEVEM SER COLOCADOS APENAS OS TIPOS DE DADOS [LEMBRAR DE APAGAR ESSAS MENSAGENS DEPOIS]
/// Representa a situação de uma viagem
pub type Situacao {
  Adiantada,
  Pontual,
  Atrasada,
  Critica
}

/// Representa regiões de uma cidade
pub type RegiaoCidade {
  Centro,
  Periferia,
  ZonaResidencial,
  ZonaComercial,
  ZonaIndustrial,
  ZonaRural
}

/// Representa um tipo de transporte, onde todos eles possuem uma quantidade máxima de passageiros
pub type Transporte {
  Van(max_passageiros: Int),
  MicroOnibus(max_passageiros: Int),
  Onibus(max_passageiros: Int)
}

/// Retorna a quantidade máxima de passageiros de um *trasporte*
pub fn capacidade_maxima(transporte: Transporte) -> Int {
  case transporte {
    Van -> 20
    MicroOnibus -> 30
    Onibus -> 45
  }
}

/// Representa uma viagem que foi realizada, onde:
/// - id deve ser um inteiro maior que 0 e não devem existir viagens com o mesmo id
/// - transporte é representado pela estrutura *Transporte*
/// - tempo_previsto e tempo_realizado representam minutos, que uma viagem deve durar e quanto ela realmente durou,
/// respectivamente. Ambos devem ser inteiros maiores que 0
/// - situacação é representado pelo tipo enumerado *Situacao*
pub type Viagem {
  Viagem(id: Int, transporte: Transporte, tempo_previsto: Int, tempo_realizado: Int, situacao: Situacao)
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
