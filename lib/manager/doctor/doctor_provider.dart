import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/doctor/apis/api.dart';
import 'package:buisness_test/data/doctor/models/all_cases_response.dart';
import 'package:buisness_test/data/doctor/models/productResponse.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  DoctorApi api = DoctorApi();

  List<Case> cases = [];
  List<Case> completed = [];
  List<Product> products = [];

  Future<void> getAllCases() async {
    var result = await api.getAllCases();
    result.when(
      success: (data) {
        cases = data;
        notifyListeners();
      },
      error: (message, statusCode) {},
    );
  }
  Future<void> getCompletedCase() async {
    var result = await api.getCompleted();
    result.when(
      success: (data) {
        completed = data;
        notifyListeners();
      },
      error: (message, statusCode) {},
    );
  }
  Future<void> getAllProducts() async {
    var result = await api.getAllTools();
    result.when(
      success: (data) {
        products = data;
        notifyListeners();
      },
      error: (message, statusCode) {},
    );
  }

  Future<void> addProduct( {required String name,
    required String path,
    required String price})async{
    var result =await api.addTools(name: name, path: path, price: price);
    result.when(success: (data) {
      CustomToast.showSuccessToast("Tool Added Success");
    }, error: (message, statusCode) {

    },);
  }
}
