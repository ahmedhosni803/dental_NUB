import 'dart:math';
import 'package:buisness_test/core/services/custom_toast.dart';
import 'package:buisness_test/data/clinics/models/CreateDiagnoseData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/clinics/models/ClinicResponse.dart';
import 'package:buisness_test/manager/clinics/provider.dart';
import 'package:buisness_test/data/appointment/models/all_appointments.dart';
import 'package:buisness_test/manager/appointment/appointment_provider.dart';

class DiagnosisTwoScreen extends StatefulWidget {
  final AppointmentProvider provider;
  final PatientRecord? patient;

  const DiagnosisTwoScreen({
    Key? key,
    required this.provider,
     this.patient,
  }) : super(key: key);

  @override
  State<DiagnosisTwoScreen> createState() => _DiagnosisTwoScreenState();
}

class _DiagnosisTwoScreenState extends State<DiagnosisTwoScreen> {
  Set<num> selectedToothIds = {};
  String? selectedDiagnosis;
  ClinicResponse? selectedClinic;

  final List<String> diagnoses = [
    'Cavity',
    'Gum Disease',
    'Tooth Decay',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClinicsProvider()..getAllClinic(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.blue),
          title: const Text('Diagnose',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<ClinicsProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildCurvedLabel("Upper Teeth", true),
                  const SizedBox(height: 10),
                  _buildCurvedTeeth(1, 16, curveUp: true),
                  // const SizedBox(height: 30),
                  _buildCurvedLabel("Lower Teeth", false),
                  // const SizedBox(height: 10),
                  _buildCurvedTeeth(17, 32, curveUp: false),
                  const SizedBox(height: 30),
                  const Text('Diagnose',
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    value: selectedDiagnosis,
                    items: diagnoses.map((diagnosis) {
                      return DropdownMenuItem(
                        value: diagnosis,
                        child: Text(diagnosis),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => selectedDiagnosis = value),
                    hint: const Text('Select Diagnosis'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Assigned Clinic',
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ClinicResponse>(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    value: selectedClinic,
                    items: provider.clinic.map((clinic) {
                      return DropdownMenuItem(
                          value: clinic, child: Text(clinic.clinicName ?? ""));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedClinic = value);
                    },
                    hint: const Text('Select Clinic'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if (selectedToothIds.isNotEmpty &&
                            selectedDiagnosis != null &&
                            selectedClinic != null) {
                          provider.createDiagnose(CreateDiagnoseData(
                            appointID:widget.patient?.appointID.toString(),
                            assignedClinic: selectedClinic!.clinicName!,
                            finalDiagnose: selectedDiagnosis!,
                            toothNumbers: selectedToothIds.toList(),
                          ));
                          CustomToast.showSuccessToast("Diagnosis submitted successfully");
                          Navigator.popUntil(context, (route) => route.isFirst);
                          // print(
                          //     'Submitting: Tooth IDs: $selectedToothIds, Diagnosis: $selectedDiagnosis, Clinic: ${selectedClinic!.clinicName}');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select at least one tooth, diagnosis, and clinic')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('SUBMIT',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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

  /// منحنى النص
  Widget _buildCurvedLabel(String text, bool upward) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCurvedTeeth(int startId, int endId, {required bool curveUp}) {
    final total = endId - startId + 1;
    final radius = 160.0;
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(total, (index) {
          final angle = (pi / (total - 1)) * index;
          final adjustedAngle = curveUp ? -angle : angle;
          final dx = radius * cos(adjustedAngle);
          final dy = radius * sin(adjustedAngle);

          final toothId = startId + index;
          final isSelected = selectedToothIds.contains(toothId);

          return Positioned(
            left: dx + radius + 20,
            top: dy + (curveUp ? radius : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedToothIds.contains(toothId)) {
                    selectedToothIds.remove(toothId);
                  } else {
                    selectedToothIds.add(toothId);
                  }
                });
              },
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue[900] : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$toothId',
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _handleSubmit() {
    if (selectedToothIds.isNotEmpty &&
        selectedDiagnosis != null &&
        selectedClinic != null) {

      CustomToast.showSuccessToast("Diagnosis submitted successfully");
      Navigator.popUntil(context, (route) => route.isFirst);
      // print(
      //     'Submitting: Tooth IDs: $selectedToothIds, Diagnosis: $selectedDiagnosis, Clinic: ${selectedClinic!.clinicName}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please select at least one tooth, diagnosis, and clinic')),
      );
    }
  }
}
