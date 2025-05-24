class UserModel {
  final String? id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String fullname;
  final String email;
  final String role;
  String status;

  UserModel({required this.fullname, required this.email, required this.role, this.id, this.status = 'deactivated'});

  factory UserModel.fromMap (String id, Map<String, dynamic> dictionary) {
    return UserModel(
      id: id,
      fullname: dictionary['name'],
      email: dictionary['email'],
      role: dictionary['role'],
      status: dictionary['status'],
    );
  }
}
