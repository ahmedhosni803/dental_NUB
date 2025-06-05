import 'package:buisness_test/data/clinics/models/ClinicResponse.dart';
import 'package:buisness_test/data/clinics/models/CreateDiagnoseData.dart';
import 'package:buisness_test/data/clinics/models/add_clinic_data.dart';

import '../../../core/services/api_response.dart';
import '../../../core/services/base_network.dart';

class ClinicsApi {
  final NetworkService networkService = NetworkService();

  Future<ApiResponse<List<ClinicResponse>>> getAllClinics() async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.get("Clinics/GetAllClinics");
      },
      (json) {
        List<ClinicResponse> data = [];
        for (var e in json) {
          data.add(ClinicResponse.fromJson(e));
        }
        return data;
      },
    );
  }
  Future<ApiResponse<bool>> createDiagnose(CreateDiagnoseData data) async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.post("Diagnoses/CreateDiagnose",data: data.toJson());
      },
      (json) {
        return true;
      },
    );
  }
  Future<ApiResponse<bool>> addClinic(AddClinicData data) async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.post("Clinics/AddClinic",data: data.toJson());
      },
      (json) {
        return true;
      },
    );
  }
}
