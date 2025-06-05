class ClinicResponse {
  ClinicResponse({
      this.clinicName, 
      this.maxStudent, 
      this.scheduleDays, 
      this.allowedYear,});

  ClinicResponse.fromJson(dynamic json) {
    clinicName = json['clinicName'];
    maxStudent = json['maxStudent'];
    scheduleDays = json['scheduleDays'] != null ? json['scheduleDays'].cast<String>() : [];
    allowedYear = json['allowedYear'];
  }
  String? clinicName;
  num? maxStudent;
  List<String>? scheduleDays;
  num? allowedYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinicName'] = clinicName;
    map['maxStudent'] = maxStudent;
    map['scheduleDays'] = scheduleDays;
    map['allowedYear'] = allowedYear;
    return map;
  }

}