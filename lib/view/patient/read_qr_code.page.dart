import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socratize/firebase_options.dart';
import 'package:socratize/model/user.model.dart';
import 'package:socratize/model/patient.model.dart';
import 'package:socratize/model/therapist.model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ReadQRCodePage extends StatefulWidget {
  const ReadQRCodePage({super.key});

  @override
  State<ReadQRCodePage> createState() => _ReadQRCodePageState();
}

class _ReadQRCodePageState extends State<ReadQRCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool updatePatient = false;
  bool processando = false;
  bool mostrarCamera = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (processando) return;
      processando = true;

      final String? patientId = scanData.code;

      if (patientId == null) {
        _mostrarErro('QR inválido');
        return;
      }

      try {
        final patientRef = FirebaseFirestore.instance
            .collection('users')
            .doc(patientId);
        await patientRef.update({'active': 'active'});

        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/history',
            arguments: {'patientId': patientId},
          );
        }
      } catch (e) {
        _mostrarErro('Erro ao ativar paciente: $e');
      }
    });
  }

  void _mostrarErro(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    processando = false;
  }

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color(0xfffff9e3),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              height: 420,
              child: mostrarCamera
                  ? QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: Image.asset(
                            'assets/images/socratize-logo-nome.png',
                            width: 500,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 670),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Seja Bem Vindo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Clique no botão para abrir a câmera e ler seu QR Code!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              mostrarCamera = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Ler QR Code',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
