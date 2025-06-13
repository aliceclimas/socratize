import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/messages.model.dart';
import 'package:socratize/view/components/animated_chat_bubble.component.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List<MessageModel> allMessages = [];
  List<MessageModel> chatMessages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMessages();
    });
  }

  void _loadMessages() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    allMessages = args['messages'] as List<MessageModel>;

    _addMessagesToChat();
  }

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

  void _addMessagesToChat() async {
    for (int i = 0; i < allMessages.length; i++) {
      if (i > 0) {
        await Future.delayed(Duration(milliseconds: 250));
      }

      if (mounted) {
        setState(() {
          chatMessages.add(allMessages[i]);
        });
        _scrollToBottom();
      }
    }
  }

  Future<void> _shareMessages() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    String? therapistPhoneNumber;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      therapistPhoneNumber = userDoc.data()!['therapistPhoneNumber'] as String;

      if (therapistPhoneNumber.isEmpty) {
        print("Erro: Número de telefone do terapeuta não encontrado ou vazio.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Número do terapeuta não encontrado.")),
        );
        return;
      }
    } catch (e) {
      print("Erro ao buscar número do terapeuta: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao buscar dados do terapeuta.")),
      );
      return;
    }

    String formattedMessages = allMessages
        .map((msg) {
          String senderPrefix =
              msg.sender == Sender.user ? "Paciente:" : "Sistema:";
          return "$senderPrefix ${msg.text}";
        })
        .join("\n\n---\n\n");

    var url = "https://wa.me/$therapistPhoneNumber?text=${Uri.encodeComponent(formattedMessages)}";

    try {
      await launchUrl(Uri.parse(url));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível abrir o app de mensagens."),
        ),
      );
      print("Não foi possível abrir o WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/socratize-logo.png'),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
            ), // Ícone de compartilhamento padrão do Flutter
            onPressed: () {
              _shareMessages();
            },
          ),
        ],
      ),
      body: Flexible(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: chatMessages.length, // Usa apenas as mensagens do chat
          itemBuilder: (context, index) {
            final message = chatMessages[index];

            return AnimatedChatBubble(
              child: BubbleSpecialOne(
                text: message.text,
                isSender: (message.sender == Sender.system) ? false : true,
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
            );
          },
        ),
      ),
    );
  }
}
