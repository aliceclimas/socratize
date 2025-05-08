import 'package:flutter/material.dart';

List<Widget> menuPsicologo(BuildContext context) {
  return [
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
      title: const Text("Listar QR Codes"),
      onTap: () => Navigator.of(context).pushReplacementNamed('/list-qr-codes'),
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
    ),
  ];
}

List<Widget> menuPaciente(BuildContext context) {
  return [
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
      onTap: () => Navigator.of(context).pushReplacementNamed('/history'),
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
  ];
}

class Menu extends StatelessWidget {
  var isPaciente;

  Menu({super.key, this.isPaciente = true});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: isPaciente ? menuPaciente(context) : menuPsicologo(context),
        ),
      ),
    );
  }
}
