import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/clinics/api/clinics_api.dart';
import 'package:buisness_test/data/clinics/models/ClinicResponse.dart';
import 'package:buisness_test/data/clinics/models/CreateDiagnoseData.dart';
import 'package:buisness_test/data/clinics/models/add_clinic_data.dart';
import 'package:flutter/material.dart';

class ClinicsProvider extends ChangeNotifier {

  ClinicsApi api = ClinicsApi();
  List<ClinicResponse> clinic = [];


  Future<void> getAllClinic()async{
    var result = await api.getAllClinics();
    result.when(success: (data) {
      clinic = data;
      notifyListeners();
    }, error: (message, statusCode) {
      // CustomToast.showErrorToast(message);
    },);
  }

  Future<void> createDiagnose(CreateDiagnoseData data)async{

    var result = await api.createDiagnose(data);
    result.when(success: (data) {
      notifyListeners();
    }, error: (message, statusCode) {
      // CustomToast.showErrorToast(message);
    },);
  }
  Future<void> addClinic(AddClinicData data)async{

    var result = await api.addClinic(data);
    result.when(success: (data) {
      notifyListeners();
    }, error: (message, statusCode) {
      // CustomToast.showErrorToast(message);
    },);
  }

}
