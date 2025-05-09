import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
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
              leading: const Icon(Icons.psychology_alt_outlined),
              title: const Text("Perguntas"),
              onTap: () => Navigator.of(context).pushReplacementNamed('/chat'),
            ),
            ListTile(
              leading: const Icon(Icons.autorenew),
              title: const Text("Histórico de pensamentos"),
              onTap:
                  () => Navigator.of(context).pushReplacementNamed('/history'),
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text("Contactar psicólogo"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_outlined),
              title: const Text("Sair"),
              onTap: () => Navigator.of(context).popAndPushNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
