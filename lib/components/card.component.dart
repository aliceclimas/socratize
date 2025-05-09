import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class InsightCard extends StatelessWidget {
  final String tipo;
  final String frase;

  const InsightCard({super.key, required this.tipo, required this.frase});

  static const Map<String, String> explicacoes = {
    "PERSONALIZAÇÃO":
        " Assumir responsabilidade por tudo que acontece, mesmo quando não é culpa sua.",
    "FILTRO MENTAL":
        " Focar apenas nos aspectos negativos de uma situação e ignorar os positivos.",
    "GENERALIZAÃO EXCESSIVA":
        " Tirar conclusões amplas a partir de um único evento negativo, acreditando que 'sempre' será assim.",
    "CATASTROFIZAÇÃO":
        " Imaginar que o pior cenário possível vai ocorrer, exagerando as consequências de um evento.",
    "PENSAMENTO DICÓTOMO":
        "(Tudo ou nada) Ver as situações de forma extrema, sem considerar que há pontos intermediários (tudo é perfeito ou um desastre total).",
    "LEITURA DA MENTE":
        " Pressumir saber o que os outros estão pensando sem ter provas concretas.",
    "RACIOCÍNIO EMOCIONAL":
        "Considerar que, se você sente algo interessante, essa emoção reflete a verdade absoluta da situação.",
    "DESQUALIFICAÇÃO DO POSITIVO":
        "Descartar ou minimizar suas conquistas e os feedbacks positivos, focando somente nos erros.",
    "USO DE DEVERIA":
        "Impor regras rígicas sobre como as coisas 'devem' ser, levando à frustação quando a realizada não se encaixa nesses padrões.",
  };

  void mostrarExplicacao(BuildContext context) {
    final texto =
        explicacoes[tipo.toUpperCase()] ?? 'Explicação não encontrada.';
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: tipo,
      text: texto,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(frase, style: TextStyle(fontSize: 16))),
                TextButton(
                  onPressed: () {}, // ação do botão "CHAT"
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
            TextButton(
              onPressed: () => mostrarExplicacao(context),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(0xffCDD3FF)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark, color: Color(0xff5975FF)),
                  SizedBox(width: 5),
                  Text(
                    tipo.toUpperCase(),
                    style: TextStyle(color: Color(0xff5975FF)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
