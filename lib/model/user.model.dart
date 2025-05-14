import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String role;
  final bool? active; // é opcional pois paciente tem, mas terapeuta não

  UserModel(
    this.name,
    this.email,
    this.role,
    this.active
    );

    static UserModel fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
      return UserModel(
        document.data()?['name'],
        document.data()?['email'],
        document.data()?['role'],
        document.data()?['active'],
      );
    }
}
