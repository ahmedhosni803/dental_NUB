class LoginResponse {
  LoginResponse({
    this.token,
    this.userId,
    this.role,
    this.fullName,
  });

  LoginResponse.fromJson(dynamic json) {
    token = json['token'];
    userId = json['userId'];
    role = json['role'];
    fullName = json['fullName'];
  }
  String? token;
  num? userId;
  String? role;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['userId'] = userId;
    map['role'] = role;
    map['fullName'] = fullName;
    return map;
  }
}
