class AppointmentModel {
  AppointmentModel({
      this.appointmentId, 
      this.patientName, 
      this.appointmentDate, 
      this.queueNumber, 
      this.estimatedTime, 
      this.chronicalDiseases, 
      this.message, 
      this.bookingTypeName,});

  AppointmentModel.fromJson(dynamic json) {
    appointmentId = json['appointmentId'];
    patientName = json['patientName'];
    appointmentDate = json['appointmentDate'];
    queueNumber = json['queueNumber'];
    estimatedTime = json['estimatedTime'];
    chronicalDiseases = json['chronicalDiseases'];
    message = json['message'];
    bookingTypeName = json['bookingTypeName'];
  }
  num? appointmentId;
  String? patientName;
  String? appointmentDate;
  num? queueNumber;
  String? estimatedTime;
  String? chronicalDiseases;
  String? message;
  String? bookingTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointmentId'] = appointmentId;
    map['patientName'] = patientName;
    map['appointmentDate'] = appointmentDate;
    map['queueNumber'] = queueNumber;
    map['estimatedTime'] = estimatedTime;
    map['chronicalDiseases'] = chronicalDiseases;
    map['message'] = message;
    map['bookingTypeName'] = bookingTypeName;
    return map;
  }

}