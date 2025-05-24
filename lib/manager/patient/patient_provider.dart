import 'package:buisness_test/data/patient/apis/apis.dart';
import 'package:flutter/material.dart';

import '../../core/config_provider/config_provider.dart';
import '../../data/patient/models/user_model.dart';

class PatientProvider extends ChangeNotifier {
  PatientApis apis = PatientApis();
  ConfigProvider configProvider = ConfigProvider();

  Future<void> getPatient() async {
    var response = await apis.getPatient();
    response.when(
        success: (data) {
          configProvider.userModel = data;
          notifyListeners();
        },
        error: (message, statusCode) {});
  }
}
