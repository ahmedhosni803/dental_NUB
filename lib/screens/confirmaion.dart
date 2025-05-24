import 'package:buisness_test/data/appointment/models/appointment_model.dart';
import 'package:buisness_test/screens/choose_for_patient.dart';
import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/appointment_confirmation',
//       routes: {
//         '/choose_patient': (context) => ChooseForPatientScreen(
//               userName: '',
//               userEmail: '',
//             ),
//         '/appointment_confirmation': (context) => ConfirmationScreen(),
//       },
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     );
//   }
// }


class ConfirmationScreen extends StatelessWidget {
  final AppointmentModel data;
  ConfirmationScreen({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home, color: Color(0xFF1F5382)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/choose_patient');
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          // width: 300,
          // height: ,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/thank.png', 
                width: 280, 
                height: 150,
              ),
              const SizedBox(height: 30), 
               Text(
                data.message??"",
                style: TextStyle(fontSize: 20, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
               Text(
                'Your Queue number is ${data.queueNumber}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
               Text(
                'At ${data.estimatedTime}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}