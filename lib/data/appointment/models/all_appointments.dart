import 'dart:convert';

class PatientRecord {
  final String? patientName;
  final String? appointID;
  final String? patPhone;
  final String? nationalID;
  final String? gender;
  final int? age;
  final List<String>? chronicalDiseases;
  final int? cigarettesPerDay;
  final int? teethBrushingFrequency;
  final String? complaint;
  final String? xRayImage;

  PatientRecord({
    this.patientName,
    this.patPhone,
    this.appointID,
    this.nationalID,
    this.gender,
    this.age,
    this.chronicalDiseases,
    this.cigarettesPerDay,
    this.teethBrushingFrequency,
    this.complaint,
    this.xRayImage,
  });

  // Factory to parse JSON into PatientRecord
  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      patientName: json['createPatientRequest']?['patientName'] as String?,
      appointID: json['createPatientRequest']?['appointID']?.toString() as String?,
      patPhone: json['createPatientRequest']?['patPhone'] as String?,
      nationalID: json['createPatientRequest']?['nationalID'] as String?,
      gender: json['createPatientRequest']?['gender'] as String?,
      age: json['createPatientRequest']?['age'] as int?,
      chronicalDiseases:
      (json['createPatientRequest']?['chronicalDiseases'] as List<dynamic>?)
          ?.cast<String>(),
      cigarettesPerDay:
      json['createPatientRequest']?['cigarettesPerDay'] as int?,
      teethBrushingFrequency:
      json['createPatientRequest']?['teethBrushingFrequency'] as int?,
      complaint: json['complaint'] as String?,
      xRayImage: json['xRayImage'] as String?,
    );
  }

  // Convert PatientRecord to JSON
  Map<String, dynamic> toJson() {
    return {
      'createPatientRequest': {
        'patientName': patientName,
        'patPhone': patPhone,
        'nationalID': nationalID,
        'gender': gender,
        'age': age,
        'chronicalDiseases': chronicalDiseases,
        'cigarettesPerDay': cigarettesPerDay,
        'teethBrushingFrequency': teethBrushingFrequency,
      },
      'complaint': complaint,
      'xRayImage': xRayImage,
    };
  }
}

// Function to parse JSON and return List<PatientRecord>
List<PatientRecord> parsePatientRecords(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList
      .map((json) => PatientRecord.fromJson(json as Map<String, dynamic>))
      .toList();
}

