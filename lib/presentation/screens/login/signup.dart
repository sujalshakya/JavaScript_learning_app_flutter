import 'package:flutter/material.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://api.codynn.com/api';

  static Future<bool> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();

  bool _isPasswordVisible = false;

  bool _isConfirmPasswordVisible = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _signup(BuildContext context) async {
    final String username = usernameController.text;

    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Passwords do not match.'),
      ));
      return;
    }

    final bool success = await AuthService.signup(username, email, password);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      print(http.Response);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signup failed. Please try again.'),
      ));
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
          width: screenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF644AFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.010),
                const Text("Sign-up"),
                SizedBox(height: screenHeight * 0.05),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "  Full Name",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: 'Your Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "  Email",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: 'Your Email Here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Password",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixText: '  ',
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFF644AFF),
                          ),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    )),
                SizedBox(height: screenHeight * 0.02),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Confirm Password",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: screenWidth * 0.9,
                    child: TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        prefixText: '  ',
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFF644AFF),
                          ),
                        ),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                    )),
                SizedBox(height: screenHeight * 0.06),
                WideButton(
                  screenHeight: screenHeight,
                  text: 'Sign Up',
                  onPressed: () {
                    _signup(context);
                  },
                ),
                SizedBox(height: screenHeight * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Color(0xFF644AFF)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
