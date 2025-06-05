 import 'package:flutter_gemini/flutter_gemini.dart';

void classificateThought() {

final gemini = Gemini.instance;
    gemini
        .prompt(
          parts: [
            Part.text("""
          TABELA DE DISFUNÇÕES COGNITIVAS:
          1. Personalização
          2. Filtro Mental
          3. Generalização Excessiva
          4. Catastrofização
          5. Pensamento Dicotômico
          6. Leitura da Mente
          7. Raciocínio Emocional
          8. Desqualificação do Positivo
          9. Uso de "Deveria"

          INSTRUÇÕES:
          - Analise o pensamento fornecido
          - Retorne APENAS o nome da disfunção cognitiva mais adequada
          - Use EXATAMENTE um dos nomes da tabela acima
          - Não adicione explicações, números ou texto extra
          - Resposta deve ser uma única linha
          - Se não conseguir identificar, retorne "Não identificado"
        """),
            Part.text('Pensamento a analisar:'),
            Part.text('pensmento teste'),
          ],
        )
        .then((value) {
          String resultado = value?.output?.trim() ?? 'sem classificação';

          // Lista das disfunções válidas para validação
          List<String> disfuncoesValidas = [
            'Personalização',
            'Filtro Mental',
            'Generalização Excessiva',
            'Catastrofização',
            'Pensamento Dicotômico',
            'Leitura da Mente',
            'Raciocínio Emocional',
            'Desqualificação do Positivo',
            'Uso de "Deveria"',
            'Não identificado',
          ];

          // Validação e limpeza da resposta
          if (!disfuncoesValidas.contains(resultado)) {
            resultado = 'sem classificação';
          }
        })
        .catchError((e) => print('exception $e'));
  }
