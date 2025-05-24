import 'package:buisness_test/core/services/base_network.dart';
import 'package:buisness_test/data/appointment/models/appointment_model.dart';

import '../../../core/services/api_response.dart';
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
}
