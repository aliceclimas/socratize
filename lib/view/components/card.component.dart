import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:socratize/model/cognitive_disfunction.model.dart';

class InsightCard extends StatelessWidget {
  InsightCard({super.key, required this.name, required this.cognitiveDisfunctionName});

  final Map<String, CognitiveDisfunction> cognitiveDisfunctionMap = {
    "personalizacao": CognitiveDisfunction(title: "Personalização" , description: "Assumir responsabilidade por tudo que acontece, mesmo quando não é culpa sua."),
    "filtro-mental": CognitiveDisfunction(title: "Filtro Mental" , description:  "Focar apenas nos aspectos negativos de uma situação e ignorar os positivos.",),
    "generalizacao-excecssiva": CognitiveDisfunction(title: "Generalização Excessiva" , description: "Tirar conclusões amplas a partir de um único evento negativo, acreditando que 'sempre' será assim."),
    "catastrofizacao": CognitiveDisfunction(title: "Catastrofização" , description: "Imaginar que o pior cenário possível vai ocorrer, exagerando as consequências de um evento."),
    "pensamento-dicotomico": CognitiveDisfunction(title: "Pensamento Dicotômico" , description: "(Tudo ou nada) Ver as situações de forma extrema, sem considerar que há pontos intermediários (tudo é perfeito ou um desastre total)."),
    "leitura-mental": CognitiveDisfunction(title: "Leitura Mental" , description: "Pressumir saber o que os outros estão pensando sem ter provas concretas."),
    "desqualificacao-positivo": CognitiveDisfunction(title: "Desqualificação do Positivo" , description: "Descartar ou minimizar suas conquistas e os feedbacks positivos, focando somente nos erros."),
    "raciocinio-emocional": CognitiveDisfunction(title: "Raciocinío Emocional" , description: "Considerar que, se você sente algo interessante, essa emoção reflete a verdade absoluta da situação."),
    "uso-de-deveria": CognitiveDisfunction(title: "Uso de Deveria" , description: "Impor regras rígicas sobre como as coisas 'devem' ser, levando à frustação quando a realizada não se encaixa nesses padrões.")
  };

  final String name;
  final String cognitiveDisfunctionName; // campo idDisfuncaoCogntiva do Questionamento

  void showDisfunctionInfo(BuildContext context) {
    final CognitiveDisfunction cognitiveDisfunction = cognitiveDisfunctionMap[cognitiveDisfunctionName]!;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: cognitiveDisfunction.title,
      text: cognitiveDisfunction.description,
      confirmBtnText: 'Fechar',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => showDisfunctionInfo(context),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(0xffCDD3FF)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark, color: Color(0xff5975FF)),
                  SizedBox(width: 5),
                  Text(
                    cognitiveDisfunctionMap[cognitiveDisfunctionName]!.title.toUpperCase(),
                    style: TextStyle(color: Color(0xff5975FF)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(name, style: TextStyle(fontSize: 16))),
                TextButton(
                  onPressed:
                      () => Navigator.of(
                        context,
                      ).pushNamed('/chat'), // ação do botão "CHAT"
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xffFFE894)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble, color: Color(0xffF6C102)),
                      SizedBox(width: 5),
                      Text("CHAT", style: TextStyle(color: Color(0xffF6C102))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Rótulo com o tipo do pensamento
          ],
        ),
      ),
    );
  }
}
