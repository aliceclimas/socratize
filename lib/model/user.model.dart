import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String fullname;
  final String email;
  final String role;
  final bool active;

  UserModel({required this.fullname, required this.email, required this.role, this.id, this.active = false});

  static UserModel fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return UserModel(
      fullname: document.data()?['name'],
      email: document.data()?['email'],
      role: document.data()?['role'],
      active: document.data()?['active'],
    );
  }
}
