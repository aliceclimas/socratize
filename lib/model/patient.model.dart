import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socratize/model/user.model.dart';

class PatientModel extends UserModel {
  final String idTherapist;

  PatientModel({required super.fullname, required super.email, required super.role, required this.idTherapist, super.id, super.active});

  static PatientModel fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return PatientModel(
      fullname: document.data()?['name'],
      email: document.data()?['email'],
      role: document.data()?['role'],
      idTherapist: document.data()?['idTherapist'],
      active: document.data()?['active'],
    );
  }
}
