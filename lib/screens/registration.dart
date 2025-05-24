import 'package:buisness_test/core/routes/app_route_name.dart';
import 'package:buisness_test/manager/appointment/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'upload.dart';
import 'health_history.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color customBlue = const Color(0xFF1F5382);

    return ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: customBlue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Registration',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F5382),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildLabeledTextField("Full Name ", "Enter Your Name",
                      provider.fullNameController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  _buildLabeledTextField("Phone Number ", "Enter Your Phone",
                      provider.phoneNumberController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  _buildLabeledTextField(
                      "National ID ",
                      "Enter Your National ID Number",
                      provider.nationalIdController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  _buildLabeledTextField(
                      "Age ", "Enter Your Age", provider.ageController,
                      isRequired: true),
                  const SizedBox(height: 20),
                  _buildLabeledTextField("Address", "Enter Your Address",
                      provider.addressController),
                  const SizedBox(height: 20),
                  _buildTitle("Select your Gender *"),
                  Row(
                    children: [
                      _buildRadioButton("Male", "Male",
                          group: "gender",
                          selectedValue: provider.gender,
                          onChanged: provider.setGender),
                      const SizedBox(width: 8),
                      _buildRadioButton("Female", "Female",
                          group: "gender",
                          selectedValue: provider.gender,
                          onChanged: provider.setGender),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTitle("Choose your complaint *"),
                  DropdownButtonFormField<String>(
                    value:
                        provider.complaint.isEmpty ? null : provider.complaint,
                    hint: const Text(
                      "Select Your Complaint",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    onChanged: (String? newValue) {
                      provider.setComplaint(newValue!);
                    },
                    validator: (value) =>
                        value == null ? 'Please select a complaint' : null,
                    items: <String>[
                      "الم في الاسنان",
                      "حشو",
                      "تنظيف جير",
                      "زراعة",
                      "تركيبات"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTitle("Select your Booking *"),
                  Row(
                    children: [
                      _buildRadioButton("Normal", "Normal",
                          group: "booking",
                          selectedValue: provider.bookingType,
                          onChanged: provider.setBookingType),
                      const SizedBox(width: 8),
                      _buildRadioButton("VIP", "VIP",
                          group: "booking",
                          selectedValue: provider.bookingType,
                          onChanged: provider.setBookingType),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTitle("Do you brush your teeth?"),
                  Row(
                    children: [
                      _buildCheckbox("Yes", true,
                          isBrushing: true,
                          selectedValue: provider.brushTeeth,
                          onChanged: provider.setBrushTeeth),
                      const SizedBox(width: 8),
                      _buildCheckbox("No", false,
                          isBrushing: true,
                          selectedValue: provider.brushTeeth,
                          onChanged: provider.setBrushTeeth),
                    ],
                  ),
                  if (provider.brushTeeth == true) ...[
                    const SizedBox(height: 20),
                    _buildCounter(
                        "How many times a day?", provider.timesBrushing, (val) {
                      provider.setTimesBrushing(val);
                    }),
                  ],
                  const SizedBox(height: 20),
                  _buildTitle("Do you smoke?"),
                  Row(
                    children: [
                      _buildCheckbox("Yes", true,
                          isSmoking: true,
                          selectedValue: provider.smoke,
                          onChanged: provider.setSmoke),
                      const SizedBox(width: 8),
                      _buildCheckbox("No", false,
                          isSmoking: true,
                          selectedValue: provider.smoke,
                          onChanged: provider.setSmoke),
                    ],
                  ),
                  if (provider.smoke == true) ...[
                    const SizedBox(height: 20),
                    _buildCounter(
                        "How many cigarettes a day?", provider.cigarettesPerDay,
                        (val) {
                      provider.setCigarettesPerDay(val);
                    }),
                  ],
                  const SizedBox(height: 20),
                  _buildUploadField("Upload", () {
                    Navigator.pushNamed(context, AppRouteName.uploadXray,
                        arguments: provider);
                  }),
                  const SizedBox(height: 20),
                  _buildButton("Next", customBlue, () {
                    // Validate required fields before navigating
                    if (provider.fullNameController.text.isEmpty ||
                        provider.phoneNumberController.text.isEmpty ||
                        provider.nationalIdController.text.isEmpty ||
                        provider.ageController.text.isEmpty ||
                        provider.gender.isEmpty ||
                        provider.complaint.isEmpty ||
                        provider.bookingType.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all required fields')),
                      );
                      return;
                    }
                    Navigator.pushReplacementNamed(
                        context, AppRouteName.healthHistory,
                        arguments: provider);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HealthHistoryScreen()));
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            text.replaceAll('*', ''),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F5382),
            ),
          ),
          if (text.contains('*'))
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLabeledTextField(
      String label, String hint, TextEditingController controller,
      {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F5382),
                ),
              ),
              if (isRequired)
                const Text(
                  " *",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            validator: isRequired
                ? (value) => value!.isEmpty ? 'This field is required' : null
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String label, String value,
      {required String group,
      required String selectedValue,
      required Function(String) onChanged}) {
    bool isSelected = selectedValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onChanged(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1F5382)),
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? const Color(0xFF1F5382) : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: value,
                groupValue: selectedValue,
                onChanged: (String? newValue) {
                  onChanged(newValue!);
                },
                activeColor:
                    isSelected ? Colors.white : const Color(0xFF1F5382),
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return const Color(0xFF1F5382);
                }),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1F5382),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value,
      {bool isSmoking = false,
      bool isBrushing = false,
      required bool? selectedValue,
      required Function(bool?) onChanged}) {
    bool? isSelected = selectedValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onChanged(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1F5382)),
            borderRadius: BorderRadius.circular(10),
            color: isSelected == true ? const Color(0xFF1F5382) : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                },
                activeColor: const Color(0xFF1F5382),
                checkColor: Colors.white,
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected == true
                      ? Colors.white
                      : const Color(0xFF1F5382),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int count, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF1F5382)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1F5382)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: const Color(0xFF1F5382),
                  onPressed: () {
                    if (count > 0) {
                      onChanged(count - 1);
                    }
                  },
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: const Color(0xFF1F5382),
                  onPressed: () {
                    onChanged(count + 1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadField(String hint, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, color: Colors.grey),
            const SizedBox(width: 10),
            Text(hint,
                style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
