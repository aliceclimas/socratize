class UserModel {
  final String? id; // id pode ser nulo se ele ainda não foi salvo no bd
  final String fullname;
  final String email;
  final String role;
  final bool active;

  UserModel({required this.fullname, required this.email, required this.role, this.id, this.active = false});

  factory UserModel.fromMap (Map<String, dynamic> dictionary) {
    return UserModel(
      id: dictionary['id'],
      fullname: dictionary['name'],
      email: dictionary['email'],
      role: dictionary['role'],
      active: dictionary['active'],
    );
  }
}
