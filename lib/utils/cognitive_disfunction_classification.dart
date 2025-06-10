import 'package:flutter_gemini/flutter_gemini.dart';

Future<String> classificateThought(List<Map<String, dynamic>> mensagens) async {
  try {
    final gemini = Gemini.instance;

    // Converter as mensagens em texto formatado
    String conversaFormatada = _formatarConversa(mensagens);

    final response = await gemini.prompt(
      parts: [
        Part.text("""
          TABELA DE DISFUNÇÕES COGNITIVAS:
          1. personalizacao
          2. filtro-mental
          3. generalizacao-excessiva
          4. catastrofizacao
          5. pensamento-dicotomico
          6. leitura-da-mente
          7. raciocinio-emocional
          8. desqualificacao-do-positivo
          9. uso-de-deveria

          INSTRUÇÕES OBRIGATÓRIAS:
          - Analise cuidadosamente TODA a conversa fornecida
          - Identifique padrões de pensamento disfuncionais nas falas do paciente
          - Você DEVE escolher obrigatoriamente UMA das 9 disfunções da tabela acima
          - Retorne APENAS o nome da disfunção cognitiva mais adequada
          - Use EXATAMENTE um dos nomes da tabela acima
          - Não adicione explicações, números ou texto extra
          - Resposta deve ser uma única linha
          - É OBRIGATÓRIO classificar, mesmo que seja uma aproximação
          - Se houver múltiplas disfunções, escolha a mais predominante
          - Foque especialmente nas últimas falas do paciente para identificar o padrão principal
        """),
        Part.text('Conversa completa para análise:'),
        Part.text(conversaFormatada),
        Part.text('LEMBRE-SE: Escolha obrigatoriamente UMA das 9 disfunções listadas acima.'),
      ],
    );

    String resultado = response?.output?.trim() ?? '';

    // Lista das disfunções válidas para validação
    List<String> disfuncoesValidas = [
      'personalizacao',
      'filtro-mental',
      'generalizacao-excessiva',
      'catastrofizacao',
      'pensamento-dicotomico',
      'leitura-da-mente',
      'raciocinio-emocional',
      'desqualificacao-do-positivo',
      'uso-de-deveria',
    ];

    // Validação e força uma classificação válida
    if (!disfuncoesValidas.contains(resultado)) {
      // Se a resposta não for válida, tenta fazer uma segunda tentativa com prompt mais direto
      return await _tentativaClassificacaoForcada(gemini, conversaFormatada, disfuncoesValidas);
    }

    return resultado;

  } catch (e) {
    print('Exception: $e');
    // Em caso de erro, retorna uma classificação padrão baseada em palavras-chave
    return _classificacaoFallback(mensagens);
  }
}

// Tentativa de classificação mais direta quando a primeira falha
Future<String> _tentativaClassificacaoForcada(
  Gemini gemini,
  String conversa,
  List<String> disfuncoes
) async {
  try {
    final response = await gemini.prompt(
      parts: [
        Part.text("""
          Você deve escolher APENAS UMA destas opções:
          1. personalizacao
          2. filtro-mental
          3. generalizacao-excessiva
          4. catastrofizacao
          5. pensamento-dicotomico
          6. leitura-da-mente
          7. raciocinio-emocional
          8. desqualificacao-do-positivo
          9. uso-de-deveria

          Responda com APENAS o nome da opção mais adequada para esta conversa:
        """),
        Part.text(conversa),
      ],
    );

    String resultado = response?.output?.trim() ?? '';

    if (disfuncoes.contains(resultado)) {
      return resultado;
    }
  } catch (e) {
    print('Segunda tentativa falhou: $e');
  }

  // Se ainda falhar, usa fallback
  return _classificacaoFallback([]);
}

// Classificação de fallback baseada em análise de palavras-chave
String _classificacaoFallback(List<Map<String, dynamic>> mensagens) {
  String textoCompleto = '';

  // Extrai todo o texto das mensagens
  for (var mensagem in mensagens) {
    final conteudo = mensagem['conteudo'] ?? mensagem['texto'] ?? '';
    textoCompleto += ' $conteudo';
  }

  textoCompleto = textoCompleto.toLowerCase();

  // Análise simples por palavras-chave para garantir uma classificação
  if (textoCompleto.contains('sempre') || textoCompleto.contains('nunca') ||
      textoCompleto.contains('todo') || textoCompleto.contains('tudo')) {
    return 'generalizacao-excessiva';
  }

  if (textoCompleto.contains('culpa') || textoCompleto.contains('minha fault') ||
      textoCompleto.contains('por minha causa')) {
    return 'personalizacao';
  }

  if (textoCompleto.contains('terrível') || textoCompleto.contains('horrível') ||
      textoCompleto.contains('catástrofe') || textoCompleto.contains('desastre')) {
    return 'catastrofizacao';
  }

  if (textoCompleto.contains('deveria') || textoCompleto.contains('tinha que') ||
      textoCompleto.contains('preciso')) {
    return 'uso-de-deveria';
  }

  if (textoCompleto.contains('pensando') || textoCompleto.contains('acha') ||
      textoCompleto.contains('certeza')) {
    return 'leitura-da-mente';
  }

  // Classificação padrão se nenhum padrão específico for encontrado
  return 'raciocinio-emocional';
}

// Função auxiliar para formatar as mensagens em texto legível
String _formatarConversa(List<Map<String, dynamic>> mensagens) {
  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < mensagens.length; i++) {
    final mensagem = mensagens[i];
    final remetente = mensagem['remetente'] ?? 'Usuario';
    final conteudo = mensagem['conteudo'] ?? mensagem['texto'] ?? '';
    final timestamp = mensagem['timestamp'] ?? '';

    buffer.writeln('$remetente: $conteudo');
    if (timestamp.isNotEmpty) {
      buffer.writeln('($timestamp)');
    }

    if (i < mensagens.length - 1) {
      buffer.writeln('---');
    }
  }

  return buffer.toString();
}
