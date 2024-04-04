import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:javascript/presentation/screens/login/enter_otp.dart';

class AuthService {
  static const String baseUrl = 'https://api.codynn.com/api';

  static Future<bool> reset(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/forget-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final TextEditingController emailController = TextEditingController();

  void _reset(BuildContext context) async {
    final String email = emailController.text;

    final bool success = await AuthService.reset(email);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EnterOTP(email: email)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white54,
        iconTheme: const IconThemeData(
          color: Color(0xFF644AFF),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.99,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF644AFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Your Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {},
                ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      _reset(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF644AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                    ),
                    child: const Text(
                      "Send Instructions",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}