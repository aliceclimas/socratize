

class Questioning {
  String id;
  String idPacient;
  String titulo;
  String pensamento;
  String idDisfuncaoCognitiva;
  DateTime data;
  List<String> answers;

  Questioning({required this.id, required this.idPacient, required this.titulo, required this.pensamento, required this.idDisfuncaoCognitiva, required this.data, required this.answers});

  factory Questioning.fromMap(Map <String, dynamic> map){
    return Questioning(
      id: map['id'],
      idPacient: map['idPaciente'],
      titulo: map['titulo'],
      pensamento: map['pensamento'], 
      idDisfuncaoCognitiva: map['idDisfuncaoCognitiva'], 
      data: map['mapa'], 
      answers: map['answer']
    );
  }
  
}


