class UserModel {
  UserModel({
    this.patientName,
    this.email,
    this.patPhone,
  });

  UserModel.fromJson(dynamic json) {
    patientName = json['patientName'] ?? json["fullName"];
    email = json['email'];
    patPhone = json['patPhone'];
  }
  String? patientName;
  String? email;
  String? patPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientName'] = patientName;
    map['email'] = email;
    map['patPhone'] = patPhone;
    return map;
  }
}
