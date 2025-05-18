

class Questioning {
  String id;
  String idPacient;
  String titulo;
  String pensamento;
  String idDisfuncaoCognitiva;
  DateTime data;
  List<String> answers;

  Questioning(this.id, this.idPacient, this.titulo, this.pensamento, this.idDisfuncaoCognitiva, this.data, this.answers);

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


