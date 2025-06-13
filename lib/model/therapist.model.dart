import 'package:socratize/model/user.model.dart';

class TherapistModel extends UserModel {
  final List<String> patientsId;
  final String phoneNumber;

  TherapistModel({required super.fullname, required super.email, required super.role, required this.patientsId, required this.phoneNumber, super.id, super.status});

  factory TherapistModel.fromMap(Map<String, dynamic> dictionary) {
    return TherapistModel(
      id: dictionary['id'],
      fullname: dictionary['name'],
      email: dictionary['email'],
      role: dictionary['role'],
      patientsId: List<String>.from(dictionary['patientsId'] ?? []),
      phoneNumber: dictionary['phoneNumber'],
      status: dictionary['status'],
    );
  }
}
