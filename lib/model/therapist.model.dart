import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socratize/model/user.model.dart';

class TherapistModel extends UserModel {
  final List<String> patientsId;

  TherapistModel({required super.fullname, required super.email, required super.role, required this.patientsId, super.id, super.active});

  static TherapistModel fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return TherapistModel(
      fullname: document.data()?['name'],
      email: document.data()?['email'],
      role: document.data()?['role'],
      patientsId: document.data()?['patientsId'],
      active: document.data()?['active'],
    );
  }
}
