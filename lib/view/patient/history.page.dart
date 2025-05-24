import 'package:flutter/material.dart';
import 'package:socratize/view/components/card.component.dart';
import 'package:socratize/view/components/patient.menu.component.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Lista com os pensamentos do paciente
  final List<Map<String, dynamic>> pensamentos = [
    {
      "id": 1,
      "tipo": "PERSONALIZAÇÃO",
      "frase": "A culpa é sempre minha, mesmo quando não depende de mim.",
    },
    {
      "id": 2,
      "tipo": "CATASTROFIZAÇÃO",
      "frase": "Se isso der errado, minha vida acaba.",
    },
    {
      "id": 3,
      "tipo": "FILTRO MENTAL",
      "frase": "Meu chefe elogiou, mas só consigo pensar naquele erro.",
    },
    {
      "id": 4,
      "tipo": "LEITURA DA MENTE",
      "frase": "Tenho certeza de que ele me acha inútil.",
    },
    {
      "id": 5,
      "tipo": "RACIOCÍNIO EMOCIONAL",
      "frase": "Me sinto um fracasso, então devo ser mesmo.",
    },
    {
      "id": 6,
      "tipo": "USO DE DEVERIA",
      "frase": "Eu deveria ser mais produtivo o tempo todo.",
    },
    {
      "id": 7,
      "tipo": "USO DE DEVERIA",
      "frase": "Eu deveria ser mais produtivo o tempo todo.",
    },
    {
      "id": 8,
      "tipo": "USO DE DEVERIA",
      "frase": "Eu deveria ser mais produtivo o tempo todo.",
    },
    {
      "id": 9,
      "tipo": "USO DE DEVERIA",
      "frase": "Eu deveria ser mais produtivo o tempo todo.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                            initialDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            lastDate: DateTime(2030),
                          ), // mostra o calendário
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: pensamentos.length,
                  itemBuilder: (context, index) {
                    final pensamento = pensamentos[index];
                    return Dismissible(
                      key: Key(pensamento['id'].toString()),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        setState(() {
                          pensamentos.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${pensamento['frase']} deletado'),
                          ),
                        );
                      },
                      child: InsightCard(
                        tipo: pensamento['tipo']!,
                        frase: pensamento['frase']!,
                      ),
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
