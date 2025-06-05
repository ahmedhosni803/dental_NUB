import 'package:buisness_test/core/services/api_response.dart';
import 'package:buisness_test/core/services/base_network.dart';
import 'package:buisness_test/data/auth/models/login_response.dart';
import 'package:buisness_test/data/auth/models/signup_data.dart';

class AuthApis {
  NetworkService networkService = NetworkService();

  Future<ApiResponse<bool>> signIn(AuthData data) async {
    try {
      var response =
          await networkService.post('Auth/signup', data: data.toJson());
      if (response.statusCode == 200) {
        return ApiResponse.success(true);
      } else {
        return ApiResponse.error(response.statusMessage ?? 'Unknown error');
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<LoginResponse>> login(AuthData data) async {
    return ApiResponse.executeApiCall<LoginResponse>(
      () {
        return networkService.post('Auth/login', data: data.toJson());
      },
      (json) => LoginResponse.fromJson(json),
    );

    // try{
    //   var response = await networkService.post('Auth/login', data: data.toJson());
    //   if(response.statusCode == 200) {
    //     return ApiResponse.success(
    //       LoginResponse.fromJson(response.data),
    //     );
    //   } else {
    //     return ApiResponse.error(response.statusMessage ?? 'Unknown error');
    //   }
    // }catch(e){
    //   return ApiResponse.error(e.toString());
    // }
  }

  Future<ApiResponse<bool>> otp(String otp) async {
    return ApiResponse.executeApiCall<bool>(
      () {
        return networkService
            .post('Auth/verify-email', data: {"Code": otp});
      },
      (json) => true,
    );

    // try{
    //   var response = await networkService.post('Auth/login', data: data.toJson());
    //   if(response.statusCode == 200) {
    //     return ApiResponse.success(
    //       LoginResponse.fromJson(response.data),
    //     );
    //   } else {
    //     return ApiResponse.error(response.statusMessage ?? 'Unknown error');
    //   }
    // }catch(e){
    //   return ApiResponse.error(e.toString());
    // }
  }
}
