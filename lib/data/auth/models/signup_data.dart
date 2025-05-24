class AuthData {
  AuthData({
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
    this.role,
  });

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fullName != null) map['fullName'] = fullName;
    if (email != null) map['email'] = email;
    if (password != null) map['password'] = password;
    if (confirmPassword != null) map['ConfirmPassword'] = confirmPassword;
    if (role != null) map['role'] = role;
    return map;
  }
}
