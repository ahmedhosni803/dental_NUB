import 'package:buisness_test/core/services/api_response.dart';
import 'package:buisness_test/core/services/base_network.dart';
import 'package:buisness_test/data/doctor/models/all_cases_response.dart';
import 'package:buisness_test/data/doctor/models/productResponse.dart';
import 'package:buisness_test/data/doctor/models/tools_details_response.dart';
import 'package:dio/dio.dart';

class DoctorApi {
  NetworkService networkService = NetworkService();

  Future<ApiResponse<List<Case>>> getAllCases() async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.get("Doctors/GetAllcases");
      },
      (json) {
        return AllCasesResponse.fromJson(json).data ?? [];
      },
    );
  }

  Future<ApiResponse<List<Case>>> getCompleted() async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.get("Doctors/GetCompletedCases");
      },
      (json) {
        return AllCasesResponse.fromJson(json).data ?? [];
      },
    );
  }

  Future<ApiResponse<List<Product>>> getAllTools() async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.get("Tools");
      },
      (json) {
        return ProductResponse.fromJson(json).product ?? [];
      },
    );
  }
  Future<ApiResponse<ToolsDetailsResponse>> getToolsDetails(String id) async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.get("Tools/$id");
      },
      (json) {
        return ToolsDetailsResponse.fromJson(json);
      },
    );
  }
  Future<ApiResponse<bool>> completeCase(String id) async {
    return ApiResponse.executeApiCall(
      () {
        return networkService.post("Doctors/CompleteCase",
        data: {
          "caseID": id
        }
        );
      },
      (json) {
        return true;
      },
    );
  }

  Future<ApiResponse<bool>> addTools(
      {required String name,
      required String path,
      required String price}) async {
    var data = FormData.fromMap({
      'Image': await MultipartFile.fromFile(path, filename: ''),
      'ToolName': name,
      'Price': price,
      'IsFree': price.isEmpty.toString()
    });
    return ApiResponse.executeApiCall(
      () {
        return networkService.post("Tools", data: data);
      },
      (json) {

        return true;
      },
    );
  }
}
