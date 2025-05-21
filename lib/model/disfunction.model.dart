class DisfunctionModel {
  final String id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String title;
  final String description;
  final String example;

  DisfunctionModel({required this.id, required this.title, required this.description, required this.example});

  factory DisfunctionModel.fromMap (Map<String, dynamic> dictionary) {
    return DisfunctionModel(
      id: dictionary['id'],
      title: dictionary['title'],
      description: dictionary['description'],
      example: dictionary['example'],
    );
  }
}
