import 'package:buisness_test/data/patient/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/config_provider/config_provider.dart';

class AccountPatientScreen extends StatefulWidget {
  final String role;
  final String userName;
  final String userEmail;
  final String? phone; // جديد: حقل المحمول

  const AccountPatientScreen({
    super.key,
    required this.role,
    required this.userName,
    required this.userEmail,
    this.phone, // جديد
  });

  @override
  State<AccountPatientScreen> createState() => _AccountPatientScreenState();
}

class _AccountPatientScreenState extends State<AccountPatientScreen> {
  late String _role;
  late String _userName;
  late String _userEmail;
  late String? _phone; // جديد: متغير للمحمول

  @override
  void initState() {
    super.initState();
    _role = widget.role;
    _userName = widget.userName;
    _userEmail = widget.userEmail;
    _phone = widget.phone; // جديد
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<ConfigProvider>(context).userModel;

    return Scaffold(
      body: Column(
        children: [
          // الجزء العلوي (أزرق)
          Container(
            width: double.infinity,
            color: const Color(0xFF1F5382),
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/account_img.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _role,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user?.name ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // الجزء السفلي (أبيض)
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildPatientInfo(context,user!),
                    const SizedBox(height: 60), // تعديل المسافة لتكون أكبر
                    _buildButton(
                      context,
                      text: 'Logout',
                      backgroundColor: const Color(0xFF1F5382),
                      textColor: Colors.white,
                      onPressed: () => _showLogoutDialog(context),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo(BuildContext context,UserModel user) {
    return Column(
      children: [
        _infoCard(Icons.person, user.name ?? ""),
        _infoCard(Icons.email, user.email ?? ""),
        if (_phone != null) _infoCard(Icons.phone, user.phone??""), // جديد: حقل المحمول
      ],
    );
  }

  Widget _infoCard(IconData icon, String info) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1F5382)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1F5382),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'LOGOUT',
          style: TextStyle(
            color: Color(0xFF1F5382),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Are you sure want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF1F5382)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F5382),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}