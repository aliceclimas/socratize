class Patient {
  String id;
  String name;
  String email;
  String idTherapist;
  bool active = false;

  Patient(this.id, this.name, this.email, this.idTherapist, [this.active = false]);
}
