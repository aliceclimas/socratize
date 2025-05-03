import 'package:flutter/material.dart';
import 'package:socratize/components/card.component.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('lib/assets/socratize-logo.png'),
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
                      onPressed: () {},
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                    InsightCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
