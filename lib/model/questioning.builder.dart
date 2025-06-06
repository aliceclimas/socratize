import 'package:socratize/model/questioning.model.dart';

class QuestioningBuilder {
  String? idPaciente;
  String? titulo;
  String? disfuncaoCognitiva;
  DateTime? data;
  List<Map<String, dynamic>>? mensagens = [];

  Questioning build() {
    if (idPaciente == null || titulo == null || titulo == null || disfuncaoCognitiva == null || data == null || mensagens == null) {
      throw Exception('Campos obrigatórios ausentes');
    }

    return Questioning(
      idPaciente: idPaciente!,
      titulo: titulo!,
      disfuncaoCognitiva: disfuncaoCognitiva!,
      data: data!,
      mensagens: mensagens!
    );
  }
}
