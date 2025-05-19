import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/therapist.model.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';

class ListQRCodes extends StatefulWidget {
  const ListQRCodes({super.key});

  @override
  State<ListQRCodes> createState() => _ListQRCodesState();
}

class _ListQRCodesState extends State<ListQRCodes> {
  // Lista com os pensamentos do paciente
  late final Future<List<String>> _getPatients;

  Future<List<String>> getPatients() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    print(uid);
    var therapistDoc =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    print('oi');
    TherapistModel therapistModel = TherapistModel.fromMap(
      therapistDoc.data()!,
    );
    print('oi');
    return therapistModel.patientsId;
  }

  @override
  void initState() {
    super.initState();
    _getPatients = getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getPatients,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Carregando");

        List<String> patients = snapshot.data!;
        return Scaffold(
          appBar: AppBar(),
          drawer: TherapistMenu(),
          body: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (context, index) => Card(),
          ),
        );
      },
    );
  }
}
