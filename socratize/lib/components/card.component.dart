import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
      shadowColor: Color(0xff252525),
      child: Padding(
        padding: const EdgeInsets.all(10.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Agora", style: TextStyle(color: Color(0xff9C9696))),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xffCDD3FF)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bookmark, color: Color(0xff5975FF)),
                      Text(
                        "CATASTROFIZAÇÃO",
                        style: TextStyle(color: Color(0xff5975FF)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Eu não presto"),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xffFFE894)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble, color: Color(0xffF6C102)),
                      Text("CHAT", style: TextStyle(color: Color(0xffF6C102))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
