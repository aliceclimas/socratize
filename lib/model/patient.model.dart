import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socratize/model/user.model.dart';

class PatientModel extends UserModel {
  final String idTherapist;

  PatientModel({
    required super.fullname,
    required super.email,
    required super.role,
    required this.idTherapist,
    super.id,
    super.status,
  });

  static PatientModel fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return PatientModel(
      fullname: document.data()?['name'],
      email: document.data()?['email'],
      role: document.data()?['role'],
      idTherapist: document.data()?['idTherapist'],
      status: document.data()?['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': fullname,
      'email': email,
      'role': role,
      'idTherapist': idTherapist,
      'status': status,
    };
  }

  Future<String> salvarPaciente(PatientModel paciente) async {
    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .add(paciente.toMap());
    return docRef.id;
  }
}
