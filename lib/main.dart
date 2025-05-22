import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socratize/firebase.options.dart';
import 'package:socratize/not_service.dart';
import 'package:socratize/theme.dart';
import 'package:socratize/view/chat.page.dart';
import 'package:socratize/view/gen_qr_code.page.dart';
import 'package:socratize/view/history.page.dart';
import 'package:socratize/view/list_qr_code.page.dart';
import 'package:socratize/view/login.page.dart';
import 'package:socratize/view/read_qr_code.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init notifications
  NotService().initNotifications();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig['apiKey']!,
      authDomain: firebaseConfig['authDomain']!,
      projectId: firebaseConfig['projectId']!,
      storageBucket: firebaseConfig['storageBucket']!,
      messagingSenderId: firebaseConfig['messagingSenderId']!,
      appId: firebaseConfig['appId']!,
    ),
  );
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
      home: Scaffold(body: LoginPage()),
      routes: {
        "/login": (context) => LoginPage(),
        "/history": (context) => HistoryPage(),
        "/chat": (context) => ChatPage(),
        "/read-qr-code": (context) => ReadQRCodePage(),
        "/gen-qr-code": (context) => GenQRCodePage(),
        "/list-qr-codes": (context) => ListQRCodes(),
      },
    );
  }
}
