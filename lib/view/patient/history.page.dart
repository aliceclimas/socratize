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

  String dateFormat(DateTime date) {
    String dia = date.day.toString().padLeft(2, '0');
    String mes = date.month.toString().padLeft(2, '0');
    String ano = date.year.toString();
    return '$dia/$mes/$ano';
  }

  late final Future<List<Questioning>> _getQuestionings;

  Future<List<Questioning>> getQuestionings() async {
    List<Questioning> listaQuestionamentos = [];

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    var querySnapshot =
        await FirebaseFirestore.instance
            .collection('questionamento')
            .where('idPaciente', isEqualTo: uid)
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

    print(FirebaseAuth.instance.currentUser?.displayName);
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
              Text(
                "Histórico de Pensamentos",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 30),
              SearchBar(
                hintText: "Pesquisar pensamento...",
                leading: Icon(Icons.search),
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
                          key: Key(questionamento.id!),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${questionamento.titulo} deletado',
                                ),
                              ),
                            );
                          },
                          child: InsightCard(
                            thought: questionamento.titulo,
                            date: dateFormat(questionamento.data),
                            cogDisName: questionamento.disfuncaoCognitiva,
                            questioningId: questionamento.id!,
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
