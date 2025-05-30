class CognitiveDisfunction {
  final String? id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String title;
  final String description;

  CognitiveDisfunction({required this.title, required this.description, this.id});

  factory CognitiveDisfunction.fromMap (String id, Map<String, dynamic> dictionary) {
    return CognitiveDisfunction(
      id: id,
      title: dictionary['title'],
      description: dictionary['description'],
    );
  }
}
