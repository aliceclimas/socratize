class QuestionsModel {
  final String? id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String text;
  final String category;

  QuestionsModel({this.id, required this.text, required this.category});

  factory QuestionsModel.fromMap (Map<String, dynamic> dictionary) {
    return QuestionsModel(
      id: dictionary['id'],
      text: dictionary['text'],
      category: dictionary['category'],
    );
  }
}
