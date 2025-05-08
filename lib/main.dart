import 'package:flutter/material.dart';
import 'package:socratize/chat.page.dart';
import 'package:socratize/gen_qr_code.page.dart';
import 'package:socratize/history.page.dart';
import 'package:socratize/login.page.dart';
import 'package:socratize/read_qr_code.page.dart';
import 'package:socratize/theme.dart';

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
      home: Scaffold(body: const LoginPage()),
      routes: {
        "/login": (context) => LoginPage(),
        "/history": (context) => HistoryPage(),
        "/chat": (context) => ChatPage(),
        "/read-qr-code": (context) => ReadQRCodePage(),
<<<<<<< HEAD
        "/generate-qr-code": (context) => GenQRCodePage(),
=======
        "/gen-qr-code": (context) => GenQRCodePage(),
>>>>>>> dev
      },
    );
  }
}
