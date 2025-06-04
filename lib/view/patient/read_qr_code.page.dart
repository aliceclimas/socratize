import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ReadQRCodePage extends StatefulWidget {
  const ReadQRCodePage({super.key});

  @override
  State<ReadQRCodePage> createState() => _ReadQRCodePageState();
}

class _ReadQRCodePageState extends State<ReadQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Color(0xfffff9e3),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 670),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Seja Bem Vindo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Clique no botão para abrir a câmera e ler seu QR Code!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: MobileScanner(
                              onDetect: (BarcodeCapture result) async {
                                final String? rawValue =
                                    result.barcodes.first.rawValue;
                                if (rawValue != null) {
                                  final Map<String, dynamic> userData =
                                      jsonDecode(
                                        rawValue,
                                      ); // paciente@gmail.com
                                  final querySnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .where(
                                            'email',
                                            isEqualTo: userData['email'],
                                          )
                                          .limit(1)
                                          .get();

                                  if (querySnapshot.docs.isNotEmpty) {
                                    await querySnapshot.docs.first.reference
                                        .update({"status": 'active'});

                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                          email: userData['email'],
                                          password: userData['password'],
                                        );

                                    if (!context.mounted) throw Exception('Erro interno');

                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/history');
                                  }
                                }
                              },
                            ),
                          ),
                        ],
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
