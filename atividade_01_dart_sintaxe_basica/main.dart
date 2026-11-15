enum Classificacao { semAvaliacoes, baixa, regular, alta }

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  // Todas as notas recebidas representam números inteiros.
  // Algumas estão fora do intervalo permitido.
  final notasRecebidas = <String, List<String>>{
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final categoriasPorApp = <String, String>{
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final contatosPorApp = <String, String?>{
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
    // Transporte Universitário não possui chave neste mapa.
  };

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  // QUESTÃO 1 — PREPARAÇÃO DOS DADOS

  for (final notas in notasRecebidas.entries) {
    notasValidasPorApp[notas.key] = <int>[];
    descartadasPorApp[notas.key] = 0;
    categoriasUnicas.add(categoriasPorApp[notas.key]!);

    for (final nota in notas.value) {
      int notaInt = int.parse(nota);

      if (notaInt >= notaMinima && notaInt <= notaMaxima) {
        notasValidasPorApp[notas.key]?.add(notaInt);
      } else {
        descartadasPorApp[notas.key] =
            (descartadasPorApp[notas.key] ?? 0) + 1;
      }
    }
  }

  // QUESTÃO 2 — RELATÓRIO
  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  for (final app in notasValidasPorApp.keys) {
    final notas = notasValidasPorApp[app]!;
    final quantidade = notas.length;
    final descartadas = descartadasPorApp[app] ?? 0;

    int soma = 0;
    int positivas = 0;

    for (final nota in notas) {
      soma += nota;
      if (nota >= notaPositiva) {
        positivas++;
      }
    }

    final media = quantidade > 0 ? soma / quantidade : null;
    final percentual = quantidade > 0
        ? (positivas / quantidade) * 100
        : null;

    Classificacao classificacao;

    if (media == null) {
      classificacao = Classificacao.semAvaliacoes;
    } else if (media < 3) {
      classificacao = Classificacao.baixa;
    } else if (media < 4) {
      classificacao = Classificacao.regular;
    } else {
      classificacao = Classificacao.alta;
    }

    final textoClassificacao = switch (classificacao) {
      Classificacao.semAvaliacoes => 'Sem avaliações',
      Classificacao.baixa => 'Baixa',
      Classificacao.regular => 'Regular',
      Classificacao.alta => 'Alta',
    };

    print('\nAplicativo: $app');
    print('Categoria: ${categoriasPorApp[app]}');
    print('Contato: ${contatosPorApp[app] ?? "Não informado"}');
    print('Notas válidas: $quantidade');
    print('Notas descartadas: $descartadas');
    print('Média: ${media?.toStringAsFixed(2) ?? "Não calculado"}');
    print('Positivas: ${percentual?.toStringAsFixed(2) ?? "Não calculado"}%'.replaceAll('Não calculado%', 'Não calculado'));
    print('Classificação: $textoClassificacao');
  }

  print('\nCATEGORIAS ENCONTRADAS');

  for (final categoria in categoriasUnicas) {
    print(categoria);
  }
}