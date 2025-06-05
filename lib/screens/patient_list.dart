import 'package:buisness_test/core/routes/app_route_name.dart';
import 'package:buisness_test/data/appointment/models/appointment_model.dart';
import 'package:buisness_test/manager/appointment/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final List<String> patients = [
    'Nagwa Ahmed Zaki',
    'Salma Mostafa Bakry',
    'Aya Nady Yassien',
    'Merna Ali Megahd',
    'Shaimaa Barakat',
    'Hager Ahmed Saeed',
    'Ahmed Yasser',
    'Hazem Bakry',
    'Mostafa Ahmed ',
    'Nada Ahmed Ali',
    'Tasneem Yasser',
    'Arwa Zanaty'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentProvider()..getAppointments(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF1F5382)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Patients list',
            style: TextStyle(
                color: Color(0xFF1F5382), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.appointments.length,
                      itemBuilder: (context, index) {
                        final patient = provider.appointments[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1F5382),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRouteName.diagnoseOne,
                                arguments: {
                                  'patient': patient,
                                  "provider": provider
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}. ${patient.patientName}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
