import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../manager/auth/auth_provider.dart';
import 'choose_for_doctor.dart';
import 'choose_for_patient.dart';
import 'login.dart';
import 'welcome_stu.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String role = arguments?['role'] ?? 'Patient';

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),

      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1F5382)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1F5382),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1F5382),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(Icons.person, "Enter Your Name", controller: provider.nameController),
                              const SizedBox(height: 20),
                              Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1F5382),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(Icons.email, "Enter Your email address", controller: provider.emailController),
                              const SizedBox(height: 20),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1F5382),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(Icons.lock, "Enter Your password", obscureText: true, controller: provider.passwordController),
                              const SizedBox(height: 20),
                              Text(
                                "Confirm password",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1F5382),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(Icons.lock, "Enter Your password", obscureText: true, controller: provider.confirmPasswordController),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    // var prefs = await SharedPreferences.getInstance();
                                    // prefs.clear();
                                    // print(role);
                                    if (provider.passwordController.text != provider.confirmPasswordController.text) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Passwords do not match")),
                                      );
                                      return;
                                    }
                                    provider.signUp(role);

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1F5382),
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save & Continue",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginScreen()),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF1F5382),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {bool obscureText = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1F5382)),
        ),
      ),
    );
  }
}