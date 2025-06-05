import 'dart:convert';

import 'package:buisness_test/core/services/base_network.dart';
import 'package:buisness_test/data/appointment/models/appointment_model.dart';

import '../../../core/services/api_response.dart';
import '../models/all_appointments.dart';
import '../models/appointment_data.dart';

class AppointmentApis {
  final NetworkService networkService = NetworkService();

  Future<ApiResponse<AppointmentModel>> bookAppointment(
      AppointmentData data) async {
    return ApiResponse.executeApiCall<AppointmentModel>(
      () async => networkService.post('Appointments/CreateAppoint',
          data: await data.toFormData()),
      (json) {
        return AppointmentModel.fromJson(json);
      },
    );
  }
  Future<ApiResponse<List<PatientRecord>>> getAppointments() async {
    return ApiResponse.executeApiCall<List<PatientRecord>>(
      () async => networkService.get('Appointments/GetAllAppointments'),
      (json) {
        return parsePatientRecords(jsonEncode(json));
      },
    );
  }
}
