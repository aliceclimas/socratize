import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientMenu extends StatefulWidget {
  const PatientMenu({super.key});

  @override
  State<PatientMenu> createState() => _PatientMenuState();
}

class _PatientMenuState extends State<PatientMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                leading: const Icon(Icons.psychology_alt_outlined),
                title: const Text("Perguntas"),
                onTap:
                    () => Navigator.of(context).pushReplacementNamed('/chat'),
              ),
              ListTile(
                leading: const Icon(Icons.autorenew),
                title: const Text("Histórico de pensamentos"),
                onTap:
                    () =>
                        Navigator.of(context).pushReplacementNamed('/history'),
              ),
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text("Contatar psicólogo"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text("Sair"),
                onTap: () => Navigator.of(context).popAndPushNamed('/login'),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red,),
            title: Text('Excluir conta', style: TextStyle(color: Colors.red)),
            onTap: () async {
              String uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance.collection('users').doc(uid).delete();
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
