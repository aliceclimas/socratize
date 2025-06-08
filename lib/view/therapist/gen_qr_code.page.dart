import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';

class GenQRCodePage extends StatefulWidget {
  const GenQRCodePage({super.key});

  @override
  State<GenQRCodePage> createState() => _GenQRCodePageState();
}

class _GenQRCodePageState extends State<GenQRCodePage> {
  bool showCode = false;
  bool showPassword = false;
  String barcodeData = "Sem dados!";
  var disabledButton = true;

  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();

  final therapistId = FirebaseAuth.instance.currentUser?.uid;

  void generateBarcode(String patientName, String patientEmail, String therapistId) {
    setState(() {
      Map<String, String> barcodeDataMap = {
        "patientName": patientName,
        "patientEmail": patientEmail,
        "therapistId": therapistId,
      };

      barcodeData = jsonEncode(barcodeDataMap);
      showCode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: TherapistMenu(),
        appBar: AppBar(),
        backgroundColor: const Color(0xfffff9e3),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/socratize-logo-nome.png',
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "Gerar QR Code",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Gere um QR Code único para um paciente. Ao escanear o código a conta será criada imediatamente e o mesmo poderá utilizar o aplicativo. ",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: nameInputController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Fulano Ciclano",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailInputController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "exemplo@provedor.com",
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                    BarcodeWidget(
                      data: barcodeData,
                      barcode: Barcode.qrCode(),
                      width: 200,
                      height: 200,
                      errorBuilder:
                          (context, error) =>
                              const SizedBox(width: 200, height: 200),
                    ),
                  const SizedBox(height: 10),

                  Text((barcodeData == 'Sem dados!') ? "QR sem dados!" : "QR Code preenchido com sucesso!"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => { generateBarcode(nameInputController.text, emailInputController.text, therapistId!) },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'GERAR',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20,
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
