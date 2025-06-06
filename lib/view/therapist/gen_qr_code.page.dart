import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/patient.model.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';

class GenQRCodePage extends StatefulWidget {
  const GenQRCodePage({super.key});

  @override
  State<GenQRCodePage> createState() => _GenQRCodePageState();
}

class _GenQRCodePageState extends State<GenQRCodePage> {
  bool showQrCode = false;
  bool passwordVisible = false;
  String? pacienteId;

  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> criarPaciente() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('Usuário não está logado.');
      return;
    }

    final idDoTerapeuta = currentUser.uid;

    final paciente = PatientModel(
      fullname: txtName.text,
      email: txtEmail.text,
      role: 'patient',
      idTherapist: idDoTerapeuta,
      status: 'deleted',
    );

    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .add(paciente.toMap());

    setState(() {
      pacienteId = docRef.id;
      showQrCode = true;
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
            child: Column(
              children: [
                Image.asset(
                  'assets/images/socratize-logo-nome.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 70),
                TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Nome completo',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1977d2),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.0,
                  ),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1977d2),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.0,
                  ),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: txtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1977d2),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.lightBlue,
                      size: 20.0,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.0,
                  ),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                if (showQrCode && pacienteId != null)
                  BarcodeWidget(
                    data: pacienteId!,
                    barcode: Barcode.qrCode(),
                    width: 200,
                    height: 200,
                    errorBuilder:
                        (context, error) =>
                            const SizedBox(width: 200, height: 200),
                  ),
                const SizedBox(height: 20),
                Text(
                  'Clique no botão para gerar o QR Code para seu paciente.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: criarPaciente,
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
    );
  }
}
