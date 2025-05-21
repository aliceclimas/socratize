import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socratize/model/therapist.model.dart';
import 'package:socratize/model/user.model.dart';
import 'package:socratize/view/components/therapist.menu.component.dart';

class ListQRCodes extends StatefulWidget {
  const ListQRCodes({super.key});

  @override
  State<ListQRCodes> createState() => _ListQRCodesState();
}

class _ListQRCodesState extends State<ListQRCodes> {
  // Lista com os pensamentos do paciente
  late final Future<List<UserModel>> _getPatients;

  Future<List<UserModel>> getPatients() async {
    List<UserModel> usersData = [];

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var therapistDoc =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    TherapistModel therapistModel = TherapistModel.fromMap(
      therapistDoc.data()!,
    );

    for (var patientID in therapistModel.patientsId) {
      var userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(patientID)
              .get();
      var user = UserModel.fromMap(userDoc.data()!);
      usersData.add(user);
    }

    return usersData;
  }

  @override
  void initState() {
    super.initState();
    _getPatients = getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: _getPatients,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Carregando");

        List<UserModel> patients = snapshot.data!;
        return Scaffold(
          appBar: AppBar(),
          drawer: TherapistMenu(),
          body: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var patient = patients[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(patient.fullname),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
