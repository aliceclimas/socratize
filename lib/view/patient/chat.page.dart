import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/messages.model.dart';
import 'package:socratize/model/questioning.builder.dart';
import 'package:socratize/model/questioning.model.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  QuestioningBuilder builder = QuestioningBuilder();
  late int currentIndex;
  late int currentQuestionsIndex;
  late List<dynamic> currentQuestions;
  late List questionsList;

  bool activateInput = false;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentIndex = -1;
    currentQuestionsIndex = 0;
    questionsList = [perguntasEsclarecimento, perguntasEvidencias, perguntasDesafiamSuposicoes, perguntasPontoDeVistaAlternativo];
    currentQuestions = questionsList[currentQuestionsIndex];
  }

  List<MessageModel> perguntasEsclarecimento = [
    MessageModel(
      text:
          "➡ Você poderia me dar um exemplo específico do que você está sentindo?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Quando você diz 'X', o que exatamente isso significa para você?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ Você pode descrever com mais detalhes o que te leva a pensar dessa forma?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ Qual é a parte mais importante ou central desse pensamento para você?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ Como esse pensamento se manifesta em suas emoções ou comportamentos?",
      isClickable: true,
      isQuestion: true,
    ),
  ];

  List<MessageModel> perguntasDesafiamSuposicoes = [
    MessageModel(
      text: "➡ Que suposições estamos fazendo aqui sem perceber?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Existe alguma crença implícita por trás do que você disse?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Isso é algo que você verificou ou apenas assumiu?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ O que aconteceria se essa suposição estivesse errada?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Essa suposição ainda faz sentido nesse contexto específico?",
      isClickable: true,
      isQuestion: true,
    ),
  ];

  List<MessageModel> perguntasEvidencias = [
    MessageModel(
      text: "➡ Que evidências você tem para apoiar essa afirmação?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Há dados concretos que sustentam esse ponto de vista?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Como você chegou a essa conclusão?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ Que tipo de prova seria suficiente para convencer alguém cético?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ O que pode estar faltando ou sendo ignorado na base dessa evidência?",
      isClickable: true,
      isQuestion: true,
    ),
  ];

  List<MessageModel> perguntasPontoDeVistaAlternativo = [
    MessageModel(
      text:
          "➡ Como outra pessoa poderia enxergar essa situação de forma diferente?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Você já considerou algum ponto de vista oposto ao seu?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text:
          "➡ Existe alguma outra interpretação possível para o que aconteceu?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ O que alguém que discorda de você poderia dizer sobre isso?",
      isClickable: true,
      isQuestion: true,
    ),
    MessageModel(
      text: "➡ Se você tivesse que defender o lado contrário, como faria?",
      isClickable: true,
      isQuestion: true,
    ),
  ];


  List<MessageModel> onChatMessages = [
    MessageModel(text: 'Você quer inserir o pensamento?'),
    MessageModel(
      text: 'Clique nessa mensagem para SIM! ✅',
      isClickable: true,
      value: 'Sim, eu quero adicionar um pensamento!',
      isChoice: true,
    ),
    MessageModel(
      text: 'Clique nessa mensagem para NÃO! ❌',
      isClickable: true,
      value: 'Não, não quero adicionar um pensamento!',
      isChoice: true,
    ),
  ];

  List<MessageModel> staticMessages = [
    MessageModel(text: 'Qual o seu pensamento?'),
    MessageModel(text: 'Escolha uma pergunta com o propósito de deixar mais claro o que você quer dizer: ', isChoice: true),
    MessageModel(text: 'Escolha uma pergunta a respeito das evidências que sustentam seu pensamento: ', isChoice: true),
    MessageModel(text: 'Escolha uma pergunta que desafie suas suposições: ', isChoice: true),
    MessageModel(text: 'Escolha uma pergunta que te ajude a pensar em uma ponto de vista alternativo: ', isChoice: true),
    MessageModel(text: 'Questionamento finalizado, parabéns confrontar seus pensamentos 🎊. Continue assim até que isso se torne um hábito.'),
  ];

  void addMessage(MessageModel message) async {
    setState(() {
      onChatMessages.add(message);
    });

    if (message.waitUser == true) {
      currentQuestionsIndex++;
      return;
    }
    currentIndex++;
    onChatMessages.add(staticMessages[currentIndex]);

    if (staticMessages[currentIndex].isChoice) {
      currentQuestions = questionsList[currentQuestionsIndex];
      for (var question in currentQuestions) {
        onChatMessages.add(question);
      }
    }
    if (currentIndex == staticMessages.length - 1) {
      builder.idPaciente = FirebaseAuth.instance.currentUser!.uid;
      builder.titulo = onChatMessages[3].text;
      builder.mensagens = onChatMessages.map((message) => message.toJson()).toList();
      builder.disfuncaoCognitiva = 'personalizacao';
      builder.data = DateTime.now();

      Questioning questionamento = builder.build();

      await FirebaseFirestore.instance.collection('questionamento').add({
        'idPaciente': questionamento.idPaciente,
        'titulo': questionamento.titulo,
        'data': questionamento.data,
        'disfuncaoCognitiva': questionamento.disfuncaoCognitiva,
        'mensagens': questionamento.mensagens,
      });
    }
  }

  void removeChoices() {
    setState(() {
      onChatMessages.removeWhere((message) => message.isChoice == true);
    });
  }

  void removeQuestions() {
    setState(() {
      onChatMessages.removeWhere((message) => message.isQuestion == true);
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
                ...onChatMessages.map((message) {
                  return GestureDetector(
                    onTap: () {
                      if (message.isClickable) {
                        if (message.isChoice) {
                          message = MessageModel(
                            text: message.value!,
                            isSender: true,
                          );
                          removeChoices();
                          addMessage(message);
                        }

                        if (message.isQuestion) {
                          print("Você acabou de clicar em ${message.text}");
                          message = MessageModel(
                            text: message.text,
                            isSender: false,
                            waitUser: true,
                          );
                          removeQuestions();
                          addMessage(message);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.1),
                      child: BubbleSpecialOne(
                        text: message.text,
                        isSender: message.isSender,
                        color:
                            message.isSender
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
                    addMessage(
                      MessageModel(text: inputController.text, isSender: true),
                    );
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
