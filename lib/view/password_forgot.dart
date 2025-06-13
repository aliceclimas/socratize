import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({super.key});

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}

class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  TextEditingController email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/socratize-logo-nome.png'),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Redefinição de senha",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Insira seu email abaixo para receber um link de redefinição de senha.",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Insira um e-mail",
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                      ),
                  SizedBox(height: 24),
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                    ),
                    onPressed: () async {
                      if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Por favor, preencha o campo de email!",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.lightBlue,
                        ));
                      } else {
                        try {
                          await _auth.sendPasswordResetEmail(email: email.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Link enviado para seu email",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.lightBlue,
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Erro ao enviar o link. Verifique o email informado.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.lightBlue,
                          ));
                        }
                      }
                    },
                    child: Text("Enviar link de redefinição de senha",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
