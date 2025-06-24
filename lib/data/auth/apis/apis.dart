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

  Future<ApiResponse<String>> forgetPassword(String email) async {
    return ApiResponse.executeApiCall<String>(
      () {
        return networkService
            .post('Auth/forget-password', data: {"email": email});
      },
      (json) => json["token"],
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

  Future<ApiResponse<bool>> otpPassword(String code, String token) async {
    return ApiResponse.executeApiCall<bool>(
      () {
        return networkService
            .post('Auth/verify-code', data: {"Code": code, "token": token});
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

  Future<ApiResponse<LoginResponse>> otp(String otp) async {
    return ApiResponse.executeApiCall<LoginResponse>(
      () {
        return networkService.post('Auth/verify-email', data: {"Code": otp});
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

  Future<ApiResponse<bool>> reSendCode(String email) async {
    return ApiResponse.executeApiCall<bool>(
      () {
        return networkService
            .post('Auth/resend-verification-code', data: {"email": email});
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

  Future<ApiResponse<bool>> resetPassword(
      String token, String password, String confirmPassword) async {
    return ApiResponse.executeApiCall<bool>(
      () {
        return networkService.post('Auth/reset-password', data: {
          "newPassword": password,
          "confirmPassword": confirmPassword,
          "token": token
        });
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
