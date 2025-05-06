import 'package:flutter/material.dart';
import 'package:socratize/login.page.dart';
import 'package:socratize/theme.dart';

void main() {
  runApp(SocratizeApp());
}

class SocratizeApp extends StatelessWidget {
  const SocratizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socratize',
      theme: socratizeTheme,
      home: LoginPage(), // Substitua por sua página inicial
    );
  }
}
