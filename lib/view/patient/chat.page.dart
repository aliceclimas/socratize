import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/messages.model.dart';
import 'package:socratize/model/questioning.builder.dart';
import 'package:socratize/model/questioning.model.dart';
import 'package:socratize/utils/cognitive_disfunction_classification.dart';
import 'package:socratize/view/components/animated_chat_bubble.component.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String username = FirebaseAuth.instance.currentUser!.displayName ?? 'Paciente';

  QuestioningBuilder builder = QuestioningBuilder();

  late int currentStep; // passo das mensagens fixas
  List<MessageModel> fixedMessages = [];
  List<MessageModel> onChatMessages = [];

  final TextEditingController inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _inputFocusNode = FocusNode();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<MessageModel> perguntasEsclarecimento = [
    MessageModel(
      text:
          "❔ Você poderia me dar um exemplo específico do que você está sentindo?",
    ),
    MessageModel(
      text: "❔ Quando você diz 'X', o que exatamente isso significa para você?",
    ),
    MessageModel(
      text:
          "❔ Você pode descrever com mais detalhes o que te leva a pensar dessa forma?",
    ),
    MessageModel(
      text:
          "❔ Qual é a parte mais importante ou central desse pensamento para você?",
    ),
    MessageModel(
      text:
          "❔ Como esse pensamento se manifesta em suas emoções ou comportamentos?",
    ),
  ];

  List<MessageModel> perguntasDesafiamSuposicoes = [
    MessageModel(text: "❔ Que suposições estamos fazendo aqui sem perceber?"),
    MessageModel(
      text: "❔ Existe alguma crença implícita por trás do que você disse?",
    ),
    MessageModel(text: "❔ Isso é algo que você verificou ou apenas assumiu?"),
    MessageModel(
      text: "❔ O que aconteceria se essa suposição estivesse errada?",
    ),
    MessageModel(
      text: "❔ Essa suposição ainda faz sentido nesse contexto específico?",
    ),
  ];

  List<MessageModel> perguntasEvidencias = [
    MessageModel(text: "❔ Que evidências você tem para apoiar essa afirmação?"),
    MessageModel(
      text: "❔ Há dados concretos que sustentam esse ponto de vista?",
    ),
    MessageModel(text: "❔ Como você chegou a essa conclusão?"),
    MessageModel(
      text:
          "❔ Que tipo de prova seria suficiente para convencer alguém cético?",
    ),
    MessageModel(
      text:
          "❔ O que pode estar faltando ou sendo ignorado na base dessa evidência?",
    ),
  ];

  List<MessageModel> perguntasPontoDeVistaAlternativo = [
    MessageModel(
      text:
          "❔ Como outra pessoa poderia enxergar essa situação de forma diferente?",
    ),
    MessageModel(
      text: "❔ Você já considerou algum ponto de vista oposto ao seu?",
    ),
    MessageModel(
      text:
          "❔ Existe alguma outra interpretação possível para o que aconteceu?",
    ),
    MessageModel(
      text: "❔ O que alguém que discorda de você poderia dizer sobre isso?",
    ),
    MessageModel(
      text: "❔ Se você tivesse que defender o lado contrário, como faria?",
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentStep = 0;

    fixedMessages = [
      MessageModel(text: 'Olá $username, insira um pensamento para começarmos a questionar:', requireInput: true),
      MessageModel(
        text:
            'Certo! $username, agora escolha uma das seguintes perguntas com o propósito de deixar mais claro o que você está pensando: ',
        choices: perguntasEsclarecimento,
      ),
      MessageModel(
        text:
            'Selecione apenas uma pergunta sobre as evidências que sustentam seu pensamento: ',
        choices: perguntasEvidencias,
      ),
      MessageModel(
        text:
            'Boa, $username. Responda uma dessas perguntas para desafiar suas suposições: ',
        choices: perguntasDesafiamSuposicoes,
      ),
      MessageModel(
        text:
            'Por último, escolha uma pergunta que te ajude a ver as coisas de um ponto de vista alternativo: ',
        choices: perguntasPontoDeVistaAlternativo,
      ),
      MessageModel(
        text:
            'Boa, $username! Parabéns por confrontar seus pensamentos🎉! Lembre-se de fazer isso constantemente para criar o hábito.',
      ),
    ];

    startChat();
  }

  void startChat() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
    onChatMessages.add(fixedMessages[currentStep]);
    });
   _inputFocusNode.requestFocus();
  }


  void handleUserInput() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      onChatMessages.add(fixedMessages[currentStep]);
    });

    if (fixedMessages[currentStep].choices != null) {
      MessageModel message = fixedMessages[currentStep];

      final choiceMessages =
          message.choices!
              .map(
                (choice) => MessageModel(
                  sender: Sender.system,
                  text: choice.text,
                  isChoiceChild: true,
                ),
              )
              .toList();

      for (var choice in choiceMessages) {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          onChatMessages.add(choice);
        });
        _scrollToBottom();
      }
    }

    if (currentStep == fixedMessages.length - 1) {
      saveQuestioning();
    }
    _scrollToBottom();
  }

  void saveQuestioning() async {
      builder.idPaciente = FirebaseAuth.instance.currentUser!.uid;
      builder.titulo = onChatMessages[1].text;
      builder.mensagens = onChatMessages.map((message) => message.toJson()).toList();
      builder.disfuncaoCognitiva = await classificateThought(builder.mensagens!);
      builder.data = DateTime.now();

      Questioning questionamento = builder.build();
      print(questionamento.disfuncaoCognitiva);

      await FirebaseFirestore.instance.collection('questionamento').add({
        'idPaciente': questionamento.idPaciente,
        'titulo': questionamento.titulo,
        'data': questionamento.data,
        'disfuncaoCognitiva': questionamento.disfuncaoCognitiva,
        'mensagens': questionamento.mensagens,
      });
    }


  void removeLast() {
    setState(() {
      onChatMessages.removeLast();
    });
    _scrollToBottom();
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
              controller: _scrollController,
              children: [
                ...onChatMessages.map((message) {
                  return GestureDetector(
                    onTap: () {
                      if (message.isChoiceChild) {

                      setState(() {
                        onChatMessages.add(MessageModel(text: message.text));
                        onChatMessages.removeWhere(
                          (message) => message.isChoiceChild == true,
                        );
                      });
                      }
                      Future.delayed(Duration(milliseconds: 100), () {
                        _inputFocusNode.requestFocus();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.1),
                      child: AnimatedChatBubble(
                        child: BubbleSpecialOne(
                          text: message.text,
                          isSender:
                              (message.sender == Sender.system) ? false : true,
                          color:
                              (message.sender == Sender.system)
                        ? Color(0xffFDEBAB)
                        : Color(0xFFA2D1FF),
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xff36454F),
                            fontWeight: FontWeight.w500,
                          ),
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    focusNode: _inputFocusNode,
                    controller: inputController,
                    decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.chat_bubble_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (inputController.text.trim().isNotEmpty) {
                      setState(() {
                        onChatMessages.add(
                          MessageModel(
                            text: inputController.text,
                            sender: Sender.user,
                          ),
                        );
                      });
                      _scrollToBottom();

                      inputController.clear();
                      currentStep++;

                      handleUserInput();
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
