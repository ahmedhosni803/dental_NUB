import 'package:buisness_test/core/services/custom_loading.dart';
import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/auth/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../core/routes/app_route_name.dart';
import '../../data/auth/models/signup_data.dart';
import '../../main.dart';
import '../../screens/choose_for_doctor.dart';
import '../../screens/choose_for_patient.dart';
import '../../screens/welcome_stu.dart';

class AuthProvider extends ChangeNotifier {
  AuthApis authApis = AuthApis();

  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Future<void> signUp(String role) async {
    Loading.show();
    AuthData data = AuthData(
        fullName: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        role: role);
    var response = await authApis.signIn(data);
    response.when(success: (data) {
      Loading.hide();

      Navigator.pushNamed(
        navigationKey.currentContext!,
        AppRouteName.otp,
        arguments: {"email": emailController.text},
      );
      CustomToast.showSuccessToast("Sign Up Success");
    }, error: (message, statusCode) {
      Loading.hide();
    });
  }

  Future<void> forgetPassword() async {
    Loading.show();
    var response = await authApis.forgetPassword(emailController.text);
    response.when(success: (data) {
      Loading.hide();
      Navigator.pushNamed(
        navigationKey.currentContext!,
        "/check_email",
        arguments: {"email": emailController.text, "token": data},
      );
      CustomToast.showSuccessToast("OTP Send Successfully");
    }, error: (message, statusCode) {
      Loading.hide();
    });
  }

  Future<void> otpPassword(String code, String token) async {
    Loading.show();
    var response = await authApis.otpPassword(code, token);
    response.when(success: (data) {
      Loading.hide();
      Navigator.pushNamed(
        navigationKey.currentContext!,
        "/reset_password",
        arguments: token,
      );
      // CustomToast.showSuccessToast("OTP Send Successfully");
    }, error: (message, statusCode) {
      Loading.hide();
    });
  }

  Future<void> otp(String code) async {
    Loading.show();
    var result = await authApis.otp(code);
    result.when(
      success: (data) {
        // Loading.hide();
        Navigator.pushAndRemoveUntil(
          navigationKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => WelcomeDoctorScreen(),
          ),
          (route) => false,
        );
        // Navigator.pushNamedAndRemoveUntil(
        //   navigationKey.currentState!.context,
        //   AppRouteName.login,
        //   (route) => false,
        // );
        CustomToast.showSuccessToast("OTP Success");
      },
      error: (message, statusCode) {
        Loading.hide();
        CustomToast.showErrorToast(message);
      },
    );
  }

  Future<void> reSendCode(String email) async {
    Loading.show();
    var result = await authApis.reSendCode(email);
    result.when(
      success: (data) {
        Loading.hide();
        // Navigator.pushNamedAndRemoveUntil(
        //   navigationKey.currentState!.context,
        //   AppRouteName.login,
        //   (route) => false,
        // );
        CustomToast.showSuccessToast("OTP Send Successfully");
      },
      error: (message, statusCode) {
        Loading.hide();
        CustomToast.showErrorToast(message);
      },
    );
  }

  Future<void> login() async {
    Loading.show();
    AuthData data = AuthData(
      email: emailController.text,
      password: passwordController.text,
    );
    var response = await authApis.login(data);
    response.when(success: (data) {
      Loading.hide();

      if (data.role == 'Patient') {
        Navigator.pushReplacementNamed(
            navigationKey.currentState!.context, AppRouteName.choosePatient,
            arguments: {
              "name": data.fullName,
              "role": data.role,
            });
      } else if (data.role == 'Doctor') {
        Navigator.pushNamedAndRemoveUntil(
          navigationKey.currentState!.context,
          AppRouteName.homeStu, (route) => false,
          // arguments: {
          //   "name": data.fullName,
          //   "role": data.role,
          // }
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(navigationKey.currentState!.context,
            AppRouteName.chooseForDoctor, (route) => false,
            arguments: {
              "name": data.fullName,
              "role": data.role,
            });
      }

      CustomToast.showSuccessToast("Login Success");
    }, error: (message, statusCode) {
      CustomToast.showErrorToast("Email or Password is incorrect");
      Loading.hide();
    });
  }

  Future<void> resetPassword(String token) async {
    Loading.show();
    var response = await authApis.resetPassword(
        token, passwordController.text, confirmPasswordController.text);
    response.when(success: (data) {
      Loading.hide();
      Navigator.pushNamed(
        navigationKey.currentContext!,
        "/password_success",
        arguments: token,
      );
      CustomToast.showSuccessToast("Reset Password Success");
    }, error: (message, statusCode) {
      Loading.hide();
    });
  }
}

// if (role == 'Consultant') {
//   Navigator.push(
//     navigationKey.currentState!.context,
//     MaterialPageRoute(
//       builder: (context) => DoctorHomeView(
//         role: role,
//         userName: nameController.text,
//         userEmail: emailController.text,
//       ),
//     ),
//   );
// } else if (role == 'Patient') {
//   Navigator.push(
//     navigationKey.currentState!.context,
//     MaterialPageRoute(
//       builder: (context) => ChooseForPatientScreen(
//         userName: nameController.text,
//         userEmail: emailController.text,
//       ),
//     ),
//   );
// } else if (role == 'Doctor') {
//   Navigator.push(
//     navigationKey.currentState!.context,
//     MaterialPageRoute(
//       builder: (context) => WelcomeDoctorScreen(
//         userName: nameController.text,
//         userEmail: emailController.text,
//       ),
//     ),
//   );
