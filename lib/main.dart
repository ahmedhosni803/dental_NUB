import 'package:buisness_test/core/routes/app_routes.dart';
import 'package:buisness_test/screens/choose_for_doctor.dart';
import 'package:buisness_test/screens/diagnose_one.dart';
import 'package:buisness_test/screens/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'core/config_provider/config_provider.dart';

var navigationKey = GlobalKey<NavigatorState>();

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
