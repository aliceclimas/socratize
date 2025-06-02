
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({super.key});

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}

class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  TextEditingController email = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Esqueci a senha"),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Enter email"),
          ),
          ElevatedButton(
              onPressed: () {
                if(email.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Por favor, preencha o campo de email",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.greenAccent,
                  ));
                }else if(email.text.isNotEmpty){
                  _auth.sendPasswordResetEmail(email: email.text.trim());
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Link enviado para seu email ",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.greenAccent,
                ));
              },
              child: Text("Redefinir senha")),
        ],
      ),
    );
  }
}