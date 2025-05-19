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
              decoration: BoxDecoration(color: Colors.blue[700]),
              accountName: Text("Paula"),
              accountEmail: Text("paula.silva@email.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage("assets/images/paula.jpg"),
                backgroundColor: Colors.transparent,
              ),
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
              onTap: () => Navigator.of(context).popAndPushNamed('/login'),
            )]
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> patientMenuItems(BuildContext context) {
  return [];
}
