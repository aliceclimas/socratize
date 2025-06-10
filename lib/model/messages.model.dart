enum Sender {user, system}

class MessageModel {

  final String text; // id pode ser nulo se ele ainda não foi salvo no bd
  final String? value;
  final Sender sender;
  final List<MessageModel>? choices;
  final bool requireInput;
  final bool isChoiceChild;

  MessageModel({
    required this.text,
    this.sender = Sender.system,
    this.value,
    this.choices,
    this.requireInput = false,
    this.isChoiceChild = false,
  });

  factory MessageModel.fromMap(Map<String, dynamic> dictionary) {
    return MessageModel(
      text: dictionary['text'],
      value: dictionary['value'],
      sender: dictionary['sender'],
      choices: dictionary['choices'],
      requireInput: dictionary['requireInput'],
      isChoiceChild: dictionary['isChoiceChild'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender.name,
    };
  }
}
