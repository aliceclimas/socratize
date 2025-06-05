import 'package:socratize/model/questioning.model.dart';

class QuestioningBuilder {
  String? id;
  String? idPacient;
  String? titulo;
  String? pensamento;
  String? idDisfuncaoCognitiva;
  DateTime? data;
  List<String> answers = [];

  Questioning build() {
    if (id == null || idPacient == null || titulo == null || pensamento == null || idDisfuncaoCognitiva == null || data == null) {
      throw Exception('Campos obrigatórios ausentes');
    }

    return Questioning(
      id: id!,
      idPacient: idPacient!,
      titulo: titulo!,
      pensamento: pensamento!,
      idDisfuncaoCognitiva: idDisfuncaoCognitiva!,
      data: data!,
      answers: answers,
    );
  }
}
