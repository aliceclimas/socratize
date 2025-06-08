import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:socratize/model/patient.model.dart';

class ReadQRCodePage extends StatefulWidget {
  const ReadQRCodePage({super.key});

  @override
  State<ReadQRCodePage> createState() => _ReadQRCodePageState();
}

class _ReadQRCodePageState extends State<ReadQRCodePage> {
  bool _isProcessingScan = false;

  Future<bool> checkPatientExists(String email) async {
    final query = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email);

    final querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      return true; // Usuário existe
    } else {
      return false; // Usuário não existe
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/socratize-logo.png'),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
        ),
      ),
      backgroundColor: const Color(0xfffff9e3),
      body: Center(
        child: Column(
          children: [
            Text(
              "Ler QR Code",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Use sua camera para ler o QR Code que seu terapeuta te enviou, essa etapa é crucial para que sua conta seja ativada!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              height: 300,
              child: MobileScanner(
                onDetect: (BarcodeCapture result) async {
                  if (_isProcessingScan) {
                    return;
                  }

                  setState(() {
                    _isProcessingScan = true;
                  });
                  try {
                    final String? barcodeData = result.barcodes.first.rawValue;

                    if (barcodeData == null ||
                        barcodeData.isEmpty ||
                        barcodeData == "Sem dados!") {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR Code inválido ou sem dados.'),
                          ),
                        );
                      }
                      return;
                    }

                    Map<String, dynamic> patientData;
                    try {
                      patientData = jsonDecode(barcodeData);
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR Code com formato inválido.'),
                          ),
                        );
                      }
                      return;
                    }

                    final patient = PatientModel(
                      fullname: patientData['patientName'],
                      email: patientData['patientEmail'],
                      role: 'patient',
                      idTherapist: patientData['therapistId'],
                      status: 'active',
                    );

                    bool patientAlreadyExists = await checkPatientExists(
                      patient.email,
                    );
                    if (patientAlreadyExists) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Paciente com email ${patient.email} já cadastrado.',
                            ),
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
                      return;
                    }

                    UserCredential userCredential = await auth
                        .createUserWithEmailAndPassword(
                          email: patient.email,
                          password: '12345678',
                        );

                    await firestore
                        .collection('users')
                        .doc(userCredential.user?.uid)
                        .set(patient.toMap());

                    var therapist =
                        await firestore
                            .collection('users')
                            .doc(patient.idTherapist)
                            .get();

                    List<dynamic> currentPatientsId =
                        therapist.data()!['patientsId'];

                    currentPatientsId.add(userCredential.user?.uid);

                    firestore
                        .collection('users')
                        .doc(patient.idTherapist)
                        .update({'patientsId': currentPatientsId});

                    // Verificar se o context ainda está montado antes de usar
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/change-password');
                      return;
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao processar QR Code: $e'),
                        ),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isProcessingScan = false;
                      });
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
