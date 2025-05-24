class Questioning {
  final String id;
  final String idPacient;
  final String titulo;
  final String pensamento;
  final String idDisfuncaoCognitiva;
  final DateTime data;
  final List<String> answers;

  Questioning({
    required this.id,
    required this.idPacient,
    required this.titulo,
    required this.pensamento,
    required this.idDisfuncaoCognitiva,
    required this.data,
    required this.answers,
  });

  factory Questioning.fromMap(Map<String, dynamic> map) {
    return Questioning(
      id: map['id'],
      idPacient: map['idPaciente'],
      titulo: map['titulo'],
      pensamento: map['pensamento'],
      idDisfuncaoCognitiva: map['idDisfuncaoCognitiva'],
      data: DateTime.parse(map['data']), 
      answers: List<String>.from(map['answers'] ?? []),
    );
  }
}



