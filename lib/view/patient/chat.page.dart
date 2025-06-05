import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:socratize/model/questioning.builder.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  QuestioningBuilder builder = QuestioningBuilder();
  int currentIndex = 0;
  bool activateInput = false;
  TextEditingController inputController = TextEditingController();

  List<Map<String, dynamic>> fixedMessagems = [
    {
      'text': 'Qual o seu pensamento?',
      'isSender': false,
      'isClickable': false,
      'value': null,
      'isChoice': false,
      'isQuestion': true,
    },
    {
      'text': 'Escolha uma pergunta do tipo Esclarecimento',
      'isSender': false,
      'isClickable': true,
      'value': 'Sim, eu quero adicionar um pensamento!',
      'isChoice': true,
      'isQuestion': false,
    },
  ];

  List<Map<String, dynamic>> displayedMessages = [
    {
      'text': 'Você quer inserir o pensamento?',
      'isSender': false,
      'isClickable': false,
      'value': null,
      'isChoice': false,
      'isQuestion': false,
    },
    {
      'text': 'Clique nessa mensagem para SIM! ✅',
      'isSender': false,
      'isClickable': true,
      'value': 'Sim, eu quero adicionar um pensamento!',
      'isChoice': true,
      'isQuestion': false,
    },
    {
      'text': 'Clique nessa mensagem para NÃO! ❌',
      'isSender': false,
      'isClickable': true,
      'value': 'Não, não quero adicionar um pensamento!',
      'isChoice': true,
      'isQuestion': false,
    },
  ];

  @override
  void initState() {
    super.initState();

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

  void _addMessage(
    String text,
    bool isSender,
    bool isClickable,
    String? value,
    bool isChoice,
    bool isQuestion,
  ) {
    setState(() {
      displayedMessages.add({
        'text': text,
        'isSender': isSender,
        'isClickable': isClickable,
        'value': value,
        'isChoice': isChoice,
        'isQuestion': isQuestion,
      });
    });

    displayedMessages.add(fixedMessagems[currentIndex]);

    if (fixedMessagems[currentIndex]['isQuestion']) {
      activateInput = true;
    }
    currentIndex++;
  }

  void _removeChoices() {
    setState(() {
      displayedMessages.removeWhere((message) => message['isChoice'] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PatientMenu(),
      appBar: AppBar(
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
                ...displayedMessages.map((message) {
                  return GestureDetector(
                    onTap: () {
                      if (message['isClickable']) {
                        if (message['isChoice']) {
                          print('certo');
                          _removeChoices();
                          _addMessage(
                            message['value'],
                            true,
                            false,
                            null,
                            false,
                            false,
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.1),
                      child: BubbleSpecialOne(
                        text: message['text'],
                        isSender: message['isSender'],
                        color:
                            message['isSender']
                                ? Color(0xff7CBEFF)
                                : Color(0xffFFCF24),
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xff36454F),
                          fontWeight: FontWeight.w500,
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
                    controller: inputController,
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
                  onPressed: () {
                    if (activateInput == false) {
                      return;
                    } else {
                      _addMessage(inputController.text, true, false, null, false, false);
                    }

                  },
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
