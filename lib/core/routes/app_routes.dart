import 'package:buisness_test/data/appointment/models/appointment_model.dart';
import 'package:buisness_test/screens/diagnosis_screen.dart';
import 'package:buisness_test/screens/otp_screen.dart';
import 'package:flutter/material.dart';

import '../../data/appointment/models/all_appointments.dart';
import '../../manager/appointment/appointment_provider.dart';
import '../../screens/About_us.dart';
import '../../screens/add_tools_screen.dart';
import '../../screens/chat.dart';
import '../../screens/check.dart';
import '../../screens/choose_for_doctor.dart';
import '../../screens/choose_for_patient.dart';
import '../../screens/choose_role.dart';
import '../../screens/community_free_screen.dart';
import '../../screens/community_groups.dart';
import '../../screens/community_store.dart';
import '../../screens/completed_cases.dart';
import '../../screens/confirmaion.dart';
import '../../screens/contact.dart';
import '../../screens/diagnose_one.dart';
import '../../screens/forgot_password.dart';
import '../../screens/health_history.dart';
import '../../screens/home_stu.dart';
import '../../screens/login.dart';
import '../../screens/onboarding_screen1.dart';
import '../../screens/onboarding_screen2.dart';
import '../../screens/password_created.dart';
import '../../screens/patient_list.dart';
import '../../screens/patient_list_screen.dart';
import '../../screens/product_details.dart';
import '../../screens/registration.dart';
import '../../screens/reset.dart';
import '../../screens/settings_screen.dart';
import '../../screens/sign.dart';
import '../../screens/splash_screen.dart';
import '../../screens/upload.dart';
import '../../screens/welcome.dart';
import 'app_route_name.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final String? routeName = settings.name;

  final dynamic arguments = settings.arguments;

  switch (routeName) {
    case AppRouteName.splash:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case AppRouteName.onboarding1:
      return MaterialPageRoute(builder: (_) => OnboardingScreen1());
    case AppRouteName.onboarding2:
      return MaterialPageRoute(builder: (_) => OnboardingScreen2());
    case AppRouteName.welcome:
      return MaterialPageRoute(builder: (_) => WelcomeScreen());
    case AppRouteName.login:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case AppRouteName.chooseRole:
      return MaterialPageRoute(builder: (_) => ChooseRoleScreen());
    case AppRouteName.signUp:
      return MaterialPageRoute(builder: (_) => SignUpScreen(),settings: settings);
    case AppRouteName.forgotPassword:
      return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
    case AppRouteName.checkEmail:
      return MaterialPageRoute(builder: (_) => CheckEmailScreen());
    case AppRouteName.resetPassword:
      return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
    case AppRouteName.passwordSuccess:
      return MaterialPageRoute(builder: (_) => PasswordSuccessScreen());
    case AppRouteName.choosePatient:
      return MaterialPageRoute(
        builder: (_) => ChooseForPatientScreen(
          userName: arguments?['name'] ?? '',
          userEmail: arguments?['email'] ?? '',
        ),
      );
    case AppRouteName.registration:
      return MaterialPageRoute(builder: (_) => RegistrationScreen());
    case AppRouteName.uploadXray:
      return MaterialPageRoute(
          builder: (_) => UploadScreen(
                provider: settings.arguments as AppointmentProvider,
              ));
    case AppRouteName.healthHistory:
      return MaterialPageRoute(
          builder: (_) => HealthHistoryScreen(
                provider: settings.arguments as AppointmentProvider,
              ));
    case AppRouteName.appointmentConfirmation:
      return MaterialPageRoute(builder: (_) => ConfirmationScreen(
        data:settings.arguments as AppointmentModel
      ));
    case AppRouteName.chat:
      return MaterialPageRoute(builder: (_) => ChatScreen());
    case AppRouteName.settings:
      return MaterialPageRoute(
        builder: (_) => SettingsScreen(
          userName: arguments?['userName'] ?? '',
          userEmail: arguments?['userEmail'] ?? '',
          role: arguments?['role'] ?? '',
          academicYear: arguments?['academicYear'] ?? '',
          phone: arguments?['phone'] ?? '',
          clinic: arguments?['clinic'] ?? '',
          id: arguments?['id'] ?? '',
        ),
      );
    case AppRouteName.chooseForDoctor:
      return MaterialPageRoute(
        builder: (_) => DoctorHomeView(
          userName: arguments?['name'] ?? '',
          userEmail: arguments?['email'] ?? '',
          role: arguments?['role'] ?? '',
        ),
      );
    case AppRouteName.patientListView:
      return MaterialPageRoute(builder: (_) => PatientListScreen());
    case AppRouteName.diagnoseOne:
      var provider = (settings.arguments as Map)["provider"] as AppointmentProvider;
      var patient = (settings.arguments as Map)["patient"] as PatientRecord;

      return MaterialPageRoute(builder: (_) => DiagnoseOneScreen(
        provider: provider,
        patient: patient
      ));
      case AppRouteName.diagnoseTwo:
      var provider = (settings.arguments as Map)["provider"] as AppointmentProvider;
      var patient = (settings.arguments as Map)["patient"] as PatientRecord;

      return MaterialPageRoute(builder: (_) => DiagnosisTwoScreen(
        provider: provider,
        patient: patient
      ));
    case AppRouteName.homeStu:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case AppRouteName.myPatientList:
      return MaterialPageRoute(builder: (_) => MyPatientListScreen());
    case AppRouteName.communityStore:
      return MaterialPageRoute(builder: (_) => CommunityStore());
    case AppRouteName.communityFree:
      return MaterialPageRoute(builder: (_) => CommunityFreeScreen());
      case AppRouteName.otp:
      return MaterialPageRoute(builder: (_) => OtpScreen());
    case AppRouteName.addTools:
      return MaterialPageRoute(
        builder: (_) => AddToolsScreen(
          onAddProduct: arguments?['onAddProduct'] ??
              (product) => print('Product added: $product'),
        ),
      );
    case AppRouteName.productDetails:
      return MaterialPageRoute(
        builder: (_) => ProductDetails(
          image: arguments?['image'] ?? '',
          title: arguments?['title'] ?? '',
          price: arguments?['price'] ?? '',
          description: arguments?['description'] ?? '',
          brand: arguments?['brand'] ?? '',
          isNew: arguments?['isNew'] ?? false,
        ),
      );
    case AppRouteName.contact:
      return MaterialPageRoute(builder: (_) => const ContactDetailsScreen());
    case AppRouteName.communityGroups:
      return MaterialPageRoute(builder: (_) => const CommunityGroupsScreen());
    case AppRouteName.aboutUs:
      return MaterialPageRoute(builder: (_) => const AboutUs());
    case AppRouteName.completedCases:
      return MaterialPageRoute(builder: (_) => const CompletedCases());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for $routeName'),
          ),
        ),
      );
  }
}
