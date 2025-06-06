import 'package:cloud_firestore/cloud_firestore.dart';

class Questioning {
  final String? id;
  final String idPaciente;
  final String titulo;
  final String disfuncaoCognitiva;
  final DateTime data;
  final List<Map<String, dynamic>> mensagens;

  Questioning({
    required this.idPaciente,
    required this.titulo,
    required this.disfuncaoCognitiva,
    required this.data,
    required this.mensagens,
    this.id,
  });

  factory Questioning.fromMap(Map<String, dynamic> dict) {
    List<Map<String, dynamic>> mensagensList = [];
    if (dict['mensagens'] != null && dict['mensagens'] is List) {
      mensagensList =
          (dict['mensagens'] as List)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
    }

    return Questioning(
      id: dict['id'],
      idPaciente: dict['idPaciente'],
      titulo: dict['titulo'],
      disfuncaoCognitiva: dict['disfuncaoCognitiva'],
      data: (dict['data'] as Timestamp).toDate(),
      mensagens: mensagensList,
    );
  }
}
