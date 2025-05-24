import 'dart:convert';
import 'package:dio/dio.dart';

class AppointmentData {
  final String? xRayImage;
  final String patientName;
  final String patientPhone;
  final String nationalId;
  final String gender;
  final int age;
  final String chronicDisease;
  final int cigarettesPerDay;
  final int brushingFrequency;
  final String complaint;
  final String bookingType;

  AppointmentData({
    this.xRayImage,
    required this.patientName,
    required this.patientPhone,
    required this.nationalId,
    required this.gender,
    required this.age,
    required this.chronicDisease,
    required this.cigarettesPerDay,
    required this.brushingFrequency,
    required this.complaint,
    required this.bookingType,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (xRayImage != null)
        'XRayImage': await MultipartFile.fromFile(xRayImage!,
            filename: xRayImage!.split('/').last),
      'PatientData.PatientName': patientName,
      'PatientData.PatPhone': patientPhone,
      'PatientData.NationalID': nationalId,
      'PatientData.Gender': gender,
      'PatientData.Age': age.toString(),
      'PatientData.ChronicalDiseas': chronicDisease,
      'PatientData.CigarettesPerDay': cigarettesPerDay.toString(),
      'PatientData.TeethBrushingFrequency': brushingFrequency.toString(),
      'Complaint': complaint,
      'BookingType': bookingType,
    });
  }
}
