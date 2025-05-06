import 'package:flutter/material.dart';
import 'package:socratize/history.page.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Paula"),
            accountEmail: Text("paula.silva@email.com"),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage("assets/images/socratize-logo.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.psychology_alt_outlined),
            title: const Text("Perguntas"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.autorenew),
            title: const Text("Histórico de pensamentos"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text("Contactar psicólogo"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Perfil"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Sair"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
