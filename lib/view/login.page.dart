import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/user.model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEmailFilled = false;
  bool isPasswordFilled = false;

  void onEmailFieldChange(String email) {
    (EmailValidator.validate(email)) ? setState(() => isEmailFilled = true) : setState(() => isEmailFilled = true);
  }

  void onPasswordFieldChange(String password) {
      setState(() => isPasswordFilled = true);

      if (password.length < 8) setState(() => isPasswordFilled = false);
      if (!RegExp(r'[A-Z]').hasMatch(password)) setState(() => isPasswordFilled = false);
      if (!RegExp(r'[a-z]').hasMatch(password)) setState(() => isPasswordFilled = false);
      if (!RegExp(r'[0-9]').hasMatch(password)) setState(() => isPasswordFilled = false);
      if (!RegExp(r'[\W_]').hasMatch(password)) setState(() => isPasswordFilled = false);
      if (RegExp(r'\s').hasMatch(password)) setState(() => isPasswordFilled = false);
      if (password.length > 100) setState(() => isPasswordFilled = false);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future login(BuildContext context) async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      // falta validar se o e-mail é válido e se a senha é forte

      // autentica o usuário
      await auth.signInWithEmailAndPassword(email: email, password: password);

      // lógica para verificar se é terapeuta ou paciente
      String? id = auth.currentUser?.uid;
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(id).get();
      UserModel user = UserModel.fromDocument(userDoc);

      // navegação dinâmica
      if (context.mounted) {
        if (user.role == 'patient') {
          if (user.active!) {
            Navigator.of(context).pushNamed('/history');
          } else {
            Navigator.of(context).pushNamed('/read-qr-code');
          }
        } else if (user.role == 'therapist') {
          Navigator.of(context).pushNamed('/list-qr-codes');
        }
      }
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
      body: Center(
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
                    onChanged: onEmailFieldChange,
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
                    onChanged: onPasswordFieldChange,
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
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,

                    child: ElevatedButton(
                      onPressed:
                          (isEmailFilled && isPasswordFilled)
                              ? () async => await login(context)
                              : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty<Color?>.fromMap(
                          <WidgetStatesConstraint, Color?>{
                            ~WidgetState.disabled: Colors.blue,
                          },
                        ),
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
    );
  }
}
