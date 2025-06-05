import 'dart:io';

import 'package:buisness_test/core/routes/app_route_name.dart';
import 'package:buisness_test/core/services/custom_loading.dart';
import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/appointment/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/appointment/models/all_appointments.dart';
import '../../data/appointment/models/appointment_data.dart';
import '../../main.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentApis api = AppointmentApis();

  // Public TextEditingController instances
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<PatientRecord> appointments = []; // List to store patient records>
  // Other fields
  String gender = '';
  String complaint = '';
  String bookingType = '';
  bool? brushTeeth;
  int timesBrushing = 0;
  bool? smoke;
  int cigarettesPerDay = 0;
  File? xRayImage;
  // Setters for non-controller fields
  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void setComplaint(String value) {
    complaint = value;
    notifyListeners();
  }

  void setBookingType(String value) {
    bookingType = value;
    notifyListeners();
  }

  void setBrushTeeth(bool? value) {
    brushTeeth = value;
    notifyListeners();
  }

  void setTimesBrushing(int value) {
    timesBrushing = value;
    notifyListeners();
  }

  void setSmoke(bool? value) {
    smoke = value;
    notifyListeners();
  }

  void setCigarettesPerDay(int value) {
    cigarettesPerDay = value;
    notifyListeners();
  }

  Future<void> bookAppointment({String? image}) async {
    Loading.show();
    var data = AppointmentData(
        patientName: fullNameController.text,
        patientPhone: phoneNumberController.text,
        nationalId: nationalIdController.text,
        gender: gender,
        age: int.parse(ageController.text),
        chronicDisease: complaint,
        bookingType: bookingType,
        brushingFrequency: timesBrushing,
        cigarettesPerDay: cigarettesPerDay,
        xRayImage: image,
        complaint: complaint);
    var response = await api.bookAppointment(data);
    response.when(success: (data) {
      Loading.hide();
      Navigator.pushReplacementNamed(navigationKey.currentState!.context,
          AppRouteName.appointmentConfirmation,
          arguments: data);
      CustomToast.showSuccessToast("Appointment Booked Successfully");
    }, error: (message, statusCode) {
      print(message);
      Loading.hide();
    });
  }

  Future<void> getAppointments() async {
    var response = await api.getAppointments();
    response.when(
        success: (data) {
          appointments = data;
          notifyListeners();
        },
        error: (message, statusCode) {});
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void addImage(File file) {
    xRayImage = file;
    notifyListeners();
  }
}
