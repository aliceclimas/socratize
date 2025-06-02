import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<Map<String, dynamic>> messages = [
    {'text': 'O que você está pensando?', 'isSender': false},
    {
      'text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel tellus sed nulla consectetur tempus.',
      'isSender': true,
    },
    {'text': 'Vamos questionar esse pensamento juntos?', 'isSender': false},
    {'text': 'OK', 'isSender': true},
    {
      'text': 'Selecione uma pergunta da categoria: Esclarecimento',
      'isSender': false,
    },
  ];

  List<String> perguntas = [
    'Você pode dar um exemplo do que está falando?',
    'Você pode explicar isso de outra forma?',
    'O que você quer dizer exatamente com isso?',
    'Qual é a principal ideia que você está tentando transmitir?',
  ];

  @override
  void initState() {
    super.initState();

    final gemini = Gemini.instance;

    gemini.prompt(parts: [
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
  Part.text('pensmento teste')
]).then((value) {
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
    'Não identificado'
  ];

  // Validação e limpeza da resposta
  if (!disfuncoesValidas.contains(resultado)) {
    resultado = 'sem classificação';
  }

  print(resultado);
}).catchError((e) => print('exception $e'));
  }

  void _addMessage(String message, bool isSender) {
    setState(() {
      messages.add({'text': message, 'isSender': isSender});
    });
  }

  void _removePerguntas() {
    setState(() {
      perguntas.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PatientMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFCF2),
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/images/socratize-logo.png'),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                ...messages.map((message) {
                  return BubbleSpecialOne(
                    text: message['text'],
                    isSender: message['isSender'],
                    color:
                        message['isSender']
                            ? Color(0xff7CBEFF)
                            : Color(0xffFFCF24),
                    textStyle: TextStyle(
                      fontSize: 10,
                      color: Color(0xff36454F),
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
                ...perguntas.map((pergunta) {
                  return GestureDetector(
                    onTap: () {
                      _addMessage(pergunta, false);
                      _removePerguntas();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.1),
                      child: BubbleSpecialOne(
                        text: pergunta,
                        isSender: false,
                        color: Color(0xffFFCF24),
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: Color(0xff36454F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: null,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
