import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/user.model.dart';
import 'package:socratize/authentication_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      // autentica o usuário
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // lógica para verificar se é terapeuta ou paciente
      String? id = FirebaseAuth.instance.currentUser?.uid;
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(id).get();

      UserModel userModel = UserModel.fromMap(userDoc.id, userDoc.data()!);
      if (userModel.status == 'deleted') throw FirebaseAuthException(code: 'O usuário está deletado.', message: 'O usuário está deletado.');
      if (userModel.status == 'deactivated') throw FirebaseAuthException(code: 'O usuário está desativado.', message: 'O usuário está desativado.');
      if (!context.mounted) throw Exception('Erro interno');

      String route = "/login";
      switch (userModel.role) {
        case 'patient': route = '/history';
        case 'therapist': route = '/list-qr-codes';
      }

      Navigator.of(context).pushReplacementNamed(route);

      // navegação dinâmica
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message!),
            action: SnackBarAction(
              label: 'Action',
              onPressed: () {
                // Code to execute.
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/socratize-logo-nome.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                Text(
                  "Bem-vindo(a)",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  "Vamos pensar juntos sobre o que está te incomodando?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "fulano@provedor.com",
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "senhasegura",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed:
                            () => {
                              Navigator.of(context).pushNamed('/forgot-password'),
                            },
                            child: Text(
                              "Esqueci a senha",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () async => await login(context),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.blue),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed:
                            () => {
                              Navigator.of(context).pushNamed('/read-qr-code'),
                            },
                        child: Text("É seu primeiro acesso?"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
