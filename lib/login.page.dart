import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            Text("Você tem certeza... ou só nunca questionou?"),
            Text(
              "Bem-vindo(a)",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right_outlined),
                          Text("LOGAR"),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text("Como conseguir acesso?"),
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
