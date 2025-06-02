import 'package:cloud_firestore/cloud_firestore.dart';

class Questioning {
  final String id;
  final String idPacient;
  final String pensamento;
  final String idDisfuncaoCognitiva;
  final DateTime data;
  final List<String> answers;

  Questioning({
    required this.id,
    required this.idPacient,
    required this.pensamento,
    required this.idDisfuncaoCognitiva,
    required this.data,
    required this.answers,
  });

  factory Questioning.fromMap(Map<String, dynamic> map) {
    return Questioning(
      id: map['id'] ?? '',
      idPacient: map['idPaciente'] ?? '',
      pensamento: map['pensamento'] ?? '',
      idDisfuncaoCognitiva: map['idDisfuncaoCognitiva'] ?? '',
      data: map['data'] != null
          ? (map['data'] as Timestamp).toDate()
          : DateTime.now(),
      answers: map['answers'] is List
          ? List<String>.from(map['answers'])
          : map['answers'] is String
              ? [map['answers']]
              : [],
    );
  }
}
