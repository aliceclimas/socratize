import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/patient.model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launch(Uri url) async {
  try {
    await launchUrl(url);
  } on Exception {
    print("Não foi possível abrir o WhatsApp");
  }
}

class PatientMenu extends StatefulWidget {
  const PatientMenu({super.key});

  @override
  State<PatientMenu> createState() => _PatientMenuState();
}

class _PatientMenuState extends State<PatientMenu> {
  late String username = "Paciente";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 246, 235, 140),
                      const Color.fromARGB(255, 124, 195, 253),
                    ],
                  ),
                ),
                accountName: Text(
                  username,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  '${FirebaseAuth.instance.currentUser?.email}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
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

                onTap: () async {
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  var patientDoc =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .get();

                  PatientModel patient = PatientModel.fromDocument(patientDoc);

                  String therapistPhoneNumber = patient.therapistPhoneNumber;

                  if (context.mounted) {
                    _launch(
                    Uri.parse(
                      'https://api.whatsapp.com/send?phone=$therapistPhoneNumber&text=Ol%C3%A1%20Terapeuta!',
                    ),
                  );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text("Sair"),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/login');
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text('Excluir conta', style: TextStyle(color: Colors.red)),
            onTap: () async {
              String uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({"status": "deleted"});
              if (context.mounted)
                Navigator.of(context).pushReplacementNamed('/login');
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
