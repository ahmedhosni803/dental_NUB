import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/auth/auth_provider.dart';

class ResetPasswordScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var token = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF1F5382)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Form(
              key:formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/reset.png', height: 200),
                    SizedBox(height: 20),
                    Text(
                      "Reset your password",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF1F5382),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "PASSWORD",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1F5382),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: provider.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF1F5382)),
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF1F5382),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),


                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "CONFIRM PASSWORD",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1F5382),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: provider.confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value != provider.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF1F5382)),
                        hintText: "Confirm password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF1F5382),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            provider.resetPassword(token);
                          }
                          // Navigator.pushNamed(context, '/password_success');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F5382),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
}