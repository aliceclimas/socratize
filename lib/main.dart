import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socratize/firebase.options.dart';
import 'package:socratize/not_service.dart';
import 'package:socratize/theme.dart';
import 'package:socratize/view/login.page.dart';
import 'package:socratize/view/patient/chat.page.dart';
import 'package:socratize/view/patient/history.page.dart';
import 'package:socratize/view/patient/read_qr_code.page.dart';
import 'package:socratize/view/therapist/gen_qr_code.page.dart';
import 'package:socratize/view/therapist/list_qr_code.page.dart';

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

class SocratizeApp extends StatefulWidget {
  const SocratizeApp({super.key});

  @override
  State<SocratizeApp> createState() => _SocratizeAppState();
}

class _SocratizeAppState extends State<SocratizeApp> {
  late Future<String> _initialRouteFuture = initialRouteHandler();
  final GlobalKey _appKey = GlobalKey();
  final GlobalKey _loadingKey = GlobalKey();

  Future<String> initialRouteHandler() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) return "/login";

      String? role =
          (await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get())
          .data()!['role'];

      switch (role) {
        case 'patient':
          return '/history';
        case 'therapist':
          return '/list-qr-codes';
        default:
          return '/login';
      }
    } catch (e) {
      print(e);
      return "/login";
    }
  }

  @override
  void initState() {
    super.initState();
    _initialRouteFuture = initialRouteHandler();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initialRouteFuture,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            key: _loadingKey,
            debugShowCheckedModeBanner: false,
            home: Center(child: CircularProgressIndicator()),
          );
        }

        return MaterialApp(
          key: _appKey,
          debugShowCheckedModeBanner: false,
          title: 'Socratize',
          theme: socratizeTheme,
          initialRoute: snapshot.data,
          routes: {
            "/login": (context) => LoginPage(),
            "/history": (context) => HistoryPage(),
            "/chat": (context) => ChatPage(),
            "/read-qr-code": (context) => ReadQRCodePage(),
            "/gen-qr-code": (context) => GenQRCodePage(),
            "/list-qr-codes": (context) => ListQRCodes(),
          },
        );
      },
    );
  }
}
