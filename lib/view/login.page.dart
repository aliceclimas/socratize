import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailFilled = false;
  bool isPasswordFilled = false;

  void onEmailFieldChange(String text) {
    if (text.isNotEmpty) {
      setState(() => isEmailFilled = true);
    } else {
      setState(() => isEmailFilled = false);
    }
  }

  void onPasswordFieldChange(String text) {
    if (text.isNotEmpty) {
      setState(() => isPasswordFilled = true);
    } else {
      setState(() => isPasswordFilled = false);
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future login(BuildContext context) async {
    try {
      String email = emailController.text;
      String password = passwordController.text;

      await auth.signInWithEmailAndPassword(email: email, password: password);

      String? id = auth.currentUser?.uid;

      var user = await firestore.collection('users').doc(id).get();
      var userRole = user.data()?['role'];

      if (userRole == 'patient') {
        // faz isso
      } else if (userRole == 'therapist') {
        // faz aquilo
      }

      if (context.mounted) Navigator.of(context).pushNamed('/read-qr-code');
    } on FirebaseAuthException catch (error) {
      print(error.code);
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
                            ~WidgetState.disabled: Colors.black,
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
