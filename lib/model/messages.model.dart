class MessageModel {
  final String text; // id pode ser nulo se ele ainda não foi salvo no bd
  final String? value;
  final bool isSender;
  final bool isClickable;
  final bool isChoice;
  final bool isQuestion;
  final bool waitUser;

  MessageModel({required this.text, this.isSender = false, this.value, this.isClickable = false , this.isChoice = false, this.isQuestion = false, this.waitUser = false});

  factory MessageModel.fromMap (Map<String, dynamic> dictionary) {
    return MessageModel(
      text: dictionary['text'],
      value: dictionary['value'],
      isSender: dictionary['isSender'],
      isClickable: dictionary['isClickable'],
      isChoice: dictionary['isChoice'],
      isQuestion: dictionary['isQuestion'],
    );
  }
}
