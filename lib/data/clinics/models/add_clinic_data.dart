class AddClinicData {
  AddClinicData({
      this.clinicName, 
      this.maxStudent, 
      this.schedule, 
      this.allowedYear,});

  AddClinicData.fromJson(dynamic json) {
    clinicName = json['clinicName'];
    maxStudent = json['maxStudent'];
    schedule = json['schedule'];
    allowedYear = json['allowedYear'];
  }
  String? clinicName;
  String? maxStudent;
  String? schedule;
  String? allowedYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinicName'] = clinicName;
    map['maxStudent'] = maxStudent;
    map['schedule'] = schedule;
    map['allowedYear'] = allowedYear;
    return map;
  }

}