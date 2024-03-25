import 'package:flutter/material.dart';
import 'package:javascript/presentation/screens/login/reset_password.dart';
import 'package:javascript/presentation/screens/login/signup.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'https://api.codynn.com/api';

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      jsonDecode(response.body);
      return true;
    } else {
      return false;
    }
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final bool success = await AuthService.login(email, password);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar2()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login failed. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.13,
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF644AFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.010),
                const Text("Sign-In to continue"),
                SizedBox(height: screenHeight * 0.1),
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
                      hintText: 'Account Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ResetPassword()),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Color(0xFF644AFF),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WideButton(
                  text: 'Sign In',
                  screenHeight: screenHeight,
                  onPressed: () {
                    _login(context);
                  },
                ),
                SizedBox(height: screenHeight * 0.1),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFAEAEAE),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("or"),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFAEAEAE),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFFF1F1F1)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/github.png',
                            height: 40,
                            width: 40,
                          )),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFFF1F1F1)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/google.webp',
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Signup()),
                        );
                      },
                      child: const Text(
                        "Sign up",
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
