import 'package:buisness_test/core/services/custom_loading.dart';
import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/doctor/apis/api.dart';
import 'package:buisness_test/data/doctor/models/all_cases_response.dart';
import 'package:buisness_test/data/doctor/models/productResponse.dart';
import 'package:buisness_test/data/doctor/models/tools_details_response.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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

  Future<void> completeCase(Case data) async {
    var result = await api.completeCase(data.caseID.toString());
    result.when(
      success: (data) {
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

  ToolsDetailsResponse? toolsDetails;
  Future<void> getToolsDetails(String id) async {
    Loading.show();
    var result = await api.getToolsDetails(id);
    result.when(
      success: (data) {
        toolsDetails = data;
        notifyListeners();
      },
      error: (message, statusCode) {},
    );
    Loading.hide();
  }

  Future<void> addProduct(
      {required String name,
      required String path,
      required String price}) async {
    Loading.show();
    var result = await api.addTools(name: name, path: path, price: price);
    Loading.hide();

    result.when(
      success: (data) {
        Navigator.pop(navigationKey.currentState!.context);
        getAllProducts();

        CustomToast.showSuccessToast("Tool Added Success");
      },
      error: (message, statusCode) {
        CustomToast.showErrorToast(message);
      },
    );
  }
}
