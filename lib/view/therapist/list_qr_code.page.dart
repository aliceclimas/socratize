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
      var user = UserModel.fromMap(userDoc.id, userDoc.data()!);
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
      builder: (context, patients) {
        return Scaffold(
          appBar: AppBar(),
          drawer: TherapistMenu(),
          body:
              (!patients.hasData)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    itemCount: patients.data!.length,
                    itemBuilder: (context, index) {
                      UserModel patient = patients.data![index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(patient.fullname),
                              IconButton(
                                icon:
                                    (patient.status == 'active')
                                        ? Icon(Icons.lock_open)
                                        : Icon(Icons.lock),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(patient.id)
                                      .update({"status": (patient.status == 'active') ? 'deactivated' : 'active'});

                                  setState(() {
                                    patients.data![index].status = (patient.status == 'active') ? 'deactivated' : 'active';
                                  });
                                },
                              ),
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
