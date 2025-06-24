class UserModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? role;

  final int? doctorYear;
  final int? universityID;
  final String? clinicName;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.role,
    this.doctorYear,
    this.universityID,
    this.clinicName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['doctorName'] ?? json['patientName'] ?? json['consName'],
      email: json['doctorEmail'] ?? json['email'] ?? json['consEmail'],
      phone: json['doctorPhone'] ?? json['patPhone'],
      role: json['role'],
      doctorYear: json['doctorYear'],
      universityID: json['universityID'],
      clinicName: json['clinicName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'doctorYear': doctorYear,
      'universityID': universityID,
      'clinicName': clinicName,
    };
  }
}
