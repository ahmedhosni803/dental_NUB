import 'package:buisness_test/data/patient/models/user_model.dart';
import 'package:flutter/material.dart';
class ConfigProvider extends ChangeNotifier {
  ConfigProvider._internal();

  static final ConfigProvider _instance = ConfigProvider._internal();

  factory ConfigProvider() {
    return _instance;
  }

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? value) {
    _userModel = value;
    notifyListeners();
  }
}
