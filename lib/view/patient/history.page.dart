import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/questioning.model.dart';
import 'package:socratize/view/components/card.component.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  /*
  // Lista de 'Questionamentos'
  final List<Map<String, dynamic>> questionamentos = [
    {
      "id": 1,
      "idDisfuncaoCognitiva": "personalizacao",
      "pensamento": "A culpa é sempre minha, mesmo quando não depende de mim.",
    },
    {
      "id": 2,
      "idDisfuncaoCognitiva": "catastrofizacao",
      "pensamento": "Se isso der errado, minha vida acaba.",
    },
    {
      "id": 3,
      "idDisfuncaoCognitiva": "filtro-mental",
      "pensamento": "Meu chefe elogiou, mas só consigo pensar naquele erro.",
    },
    {
      "id": 4,
      "idDisfuncaoCognitiva": "leitura-mental",
      "pensamento": "Tenho certeza de que ele me acha inútil.",
    },
    {
      "id": 5,
      "idDisfuncaoCognitiva": "raciocinio-emocional",
      "pensamento": "Me sinto um fracasso, então devo ser mesmo.",
    },
    {
      "id": 6,
      "idDisfuncaoCognitiva": "uso-de-deveria",
      "pensamento": "Eu deveria ser mais produtivo o tempo todo.",
    },
  ];

  */

  late final Future<List<Questioning>> _getQuestionings;

  Future<List<Questioning>> getQuestionings() async {
    List<Questioning> listaQuestionamentos = [];

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    var querySnapshot =
        await FirebaseFirestore.instance
            .collection('questionamento')
            .where('idPacient', isEqualTo: uid)
            .get();

    for (var doc in querySnapshot.docs) {
      var questionamento = Questioning.fromMap({...doc.data(), 'id': doc.id});
      listaQuestionamentos.add(questionamento);
    }

    return listaQuestionamentos;
  }

  @override
  void initState() {
    super.initState();
    _getQuestionings = getQuestionings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/socratize-logo.png'),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
        ),
      ),
      drawer: PatientMenu(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/socratize-logo-nome.png'),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
              ),
              Text(
                "Histórico de Pensamentos",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 30),
              SearchBar(
                hintText: "Pesquisar pensamento...",
                leading: Icon(Icons.search),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: DropdownButton(
                      hint: Text("Pensamento Disfuncional"),
                      items: [
                        DropdownMenuItem(
                          value: "Personalização",
                          child: Text("Personalização"),
                        ),
                        DropdownMenuItem(
                          value: "Filtro Mental",
                          child: Text("Filtro Mental"),
                        ),
                        DropdownMenuItem(
                          value: "Generalização Excessivav",
                          child: Text("Generalização Excessivav"),
                        ),
                        DropdownMenuItem(
                          value: "Catastrofização",
                          child: Text("Catastrofização"),
                        ),
                        DropdownMenuItem(
                          value: "Pensamento Dicótomo",
                          child: Text("Pensamento Dicótomo"),
                        ),
                        DropdownMenuItem(
                          value: "Leitura da Mente",
                          child: Text("Leitura da Mente"),
                        ),
                        DropdownMenuItem(
                          value: "Raciocínio Emocional",
                          child: Text("Raciocínio Emocional"),
                        ),
                        DropdownMenuItem(
                          value: "Imposição de Regras",
                          child: Text("Imposição de Regras"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed:
                          () => showDatePicker(
                            context: context,
                            firstDate: DateTime(2010),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          ),
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Expanded(
                flex: 2,
                child: FutureBuilder<List<Questioning>>(
                  future: _getQuestionings,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      print('Erro ao carregar os dados: ${snapshot.error}');
                      return Center(child: Text('Erro ao carregar dados.'));
                    }

                    final listaQuestionamentos = snapshot.data ?? [];

                    if (listaQuestionamentos.isEmpty) {
                      return Center(
                        child: Text('Nenhum pensamento encontrado.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: listaQuestionamentos.length,
                      itemBuilder: (context, index) {
                        final questionamento = listaQuestionamentos[index];

                        return Dismissible(
                          key: Key(questionamento.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            print('ID para deletar: ${questionamento.id}');

                            try {
                              await FirebaseFirestore.instance
                                  .collection('questionamento')
                                  .doc(questionamento.id)
                                  .delete();
                              print('Documento deletado!');
                            } catch (e) {
                              print('Erro ao deletar: $e');
                            }

                            /*setState(() {
                              listaQuestionamentos.removeAt(index);
                            });*/

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${questionamento.pensamento} deletado',
                                ),
                              ),
                            );
                          },
                          child: InsightCard(
                            name: questionamento.pensamento,
                            cognitiveDisfunctionName:
                                questionamento.idDisfuncaoCognitiva,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
