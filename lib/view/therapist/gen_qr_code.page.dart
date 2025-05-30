import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';

class GenQRCodePage extends StatefulWidget {
  const GenQRCodePage({super.key});

  @override
  State<GenQRCodePage> createState() => _GenQRCodePageState();
}

class _GenQRCodePageState extends State<GenQRCodePage> {
  bool showQrCode = false;
  bool passwordVisible = false;

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
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Digite o nome',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6C102),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1977d2),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
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
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Digite o e-mail',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6C102),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1977d2),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Digite a senha',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF6C102),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                          0xff1977d2,
                        ), // substituto do FlutterFlowTheme.iconeAzul
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
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
                if (showQrCode)
                  BarcodeWidget(
                    data: 'https://github.com/aliceclimas/socratize/tree/main',
                    barcode: Barcode.qrCode(),
                    width: 200,
                    height: 200,
                    errorBuilder:
                        (context, error) =>
                            const SizedBox(width: 200, height: 200),
                  ),
                const SizedBox(height: 20),
                Text(
                  'Clique no botão para gerar o Qr Code para seu paciente',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showQrCode = true;
                    });
                  },
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
                    'Gerar Qr Code',
                    style: TextStyle(color: Colors.white),
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
