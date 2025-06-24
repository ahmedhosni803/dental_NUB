import 'package:buisness_test/core/services/api_response.dart';
import 'package:buisness_test/data/patient/models/user_model.dart';

import '../../../core/services/base_network.dart';

class PatientApis {
  final NetworkService networkService = NetworkService();

  Future<ApiResponse<UserModel>> getPatient() async {
    return ApiResponse.executeApiCall<UserModel>(
      () async => networkService.get('Profile/Getprofileinfo'),
      (json) {
        return UserModel.fromJson(json);
      },
    );
  }
}
