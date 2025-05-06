import 'package:flutter/material.dart';
import 'package:socratize/history.page.dart';
import 'package:socratize/theme.dart';
import 'package:socratize/components/menu.component.dart';


void main() {
  runApp(SocratizeApp());
}

class SocratizeApp extends StatelessWidget {
  const SocratizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socratize',
      theme: socratizeTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Página Inicial"),
        ),
        drawer: const Menu(),
        body: const HistoryPage(),
        
      )
    );
  }
}

