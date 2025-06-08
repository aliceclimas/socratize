import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmNewPasswordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      confirmNewPasswordVisible = !confirmNewPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    "Redefina a senha após seu primeiro acesso.",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  TextField(
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      hintText: "Insira uma senha",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: togglePassword,
                      ),
                    ),
                    controller: passwordController,
                  ),
                  SizedBox(height: 24),
                  TextField(
                    obscureText: confirmNewPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Confirme a nova senha",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        splashRadius: 1,
                        icon: Icon(
                          confirmNewPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: toggleConfirmPassword,
                      ),
                    ),
                    controller: confirmNewPasswordController,
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
                    child: Text(
                      "Alterar senha",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () async{
                      final newPassword = passwordController.text.trim();
                      final confirmNewPassword = confirmNewPasswordController.text.trim();

                      if (newPassword != confirmNewPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "As senhas não coincidem!",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Senha alterada com sucesso!",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
                        Navigator.pushReplacementNamed(context, "/history");
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Erro ao alterar a senha. Tente novamente.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
                      }
                    },
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
