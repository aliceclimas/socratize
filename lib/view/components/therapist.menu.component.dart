import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TherapistMenu extends StatefulWidget {
  const TherapistMenu({super.key});

  @override
  State<TherapistMenu> createState() => _TherapistMenuState();
}

class _TherapistMenuState extends State<TherapistMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue[700], gradient: LinearGradient(colors: [const Color.fromARGB(255, 246, 235, 140), const Color.fromARGB(255, 124, 195, 253), ])),
                accountName: Text('${FirebaseAuth.instance.currentUser?.displayName}', style: TextStyle(fontSize: 50, color: Colors.black),),
                accountEmail: Text('${FirebaseAuth.instance.currentUser?.email}', style: TextStyle(fontSize: 16, color: Colors.black),),
              ),
            ListTile(
              leading:  const Icon(Icons.psychology_alt_outlined),
              title:  const Text("Listar QR Codes"),
              onTap:  () => Navigator.of(context).pushReplacementNamed('/list-qr-codes'),
            ),
            ListTile(
              leading: const Icon(Icons.autorenew),
              title: const Text("Gerar QR Code"),
              onTap: () => Navigator.of(context).pushReplacementNamed('/gen-qr-code'),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_outlined),
              title: const Text("Sair"),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/login');
                FirebaseAuth.instance.signOut();
              }
            )]
        ),
      ),
    );
  }
}
