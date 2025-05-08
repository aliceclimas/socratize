import 'package:flutter/material.dart';
import 'package:socratize/components/menu.component.dart';

class ListQRCodes extends StatefulWidget {
  const ListQRCodes({super.key});

  @override
  State<ListQRCodes> createState() => _ListQRCodesState();
}

class _ListQRCodesState extends State<ListQRCodes> {
  // Lista com os pensamentos do paciente
  final List<Map<String, String>> pacientes = [
    {"profilePhoto": "images/paula.jpg", "name": "Paula"},
    {"profilePhoto": "images/brain.png", "name": "José"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Menu(isPaciente: false),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: pacientes.length,
                  itemBuilder: (context, index) {
                    final paciente = pacientes[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  paciente['profilePhoto']!,
                                ),
                              ),
                            ),
                            Text(paciente['name']!),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
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
