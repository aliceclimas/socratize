import 'package:socratize/model/user.model.dart';

class TherapistModel extends UserModel {
  final List<String> patientsId;

  TherapistModel({required super.fullname, required super.email, required super.role, required this.patientsId, super.id, super.active});

  factory TherapistModel.fromMap(Map<String, dynamic> dictionary) {
    return TherapistModel(
      id: dictionary['id'],
      fullname: dictionary['name'],
      email: dictionary['email'],
      role: dictionary['role'],
      patientsId: List<String>.from(dictionary['patientsId'] ?? []),
      active: dictionary['active'],
    );
  }
}
