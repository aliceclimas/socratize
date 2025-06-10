import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/messages.model.dart';
import 'package:socratize/view/components/animated_chat_bubble.component.dart';

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
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    allMessages = args['messages'] as List<MessageModel>;

    // Inicia adicionando mensagens no chat com delay
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/socratize-logo.png'),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
        ),
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
