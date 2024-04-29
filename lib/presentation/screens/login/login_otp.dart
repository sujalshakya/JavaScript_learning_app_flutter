import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class LoginOTP extends StatefulWidget {
  final String email;

  const LoginOTP({Key? key, required this.email}) : super(key: key);

  @override
  LoginOTPState createState() => LoginOTPState();
}

class LoginOTPState extends State<LoginOTP> {
  String otp = '';

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendOTP(String email, String otp) async {
    const String apiUrl = 'https://api.codynn.com/api/user/verifyOTP';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'pin': otp,
        },
      );

      if (response.statusCode == 200) {
        print('OTP sent successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } else {
        print('${response.body}. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to send OTP. Error: $e');
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
                const Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF644AFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                    "We've sent a 6 digit otp to your email, enter the OTP below to continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    )),
                SizedBox(height: screenHeight * 0.03),
                const SizedBox(height: 8),
                OtpPinField(
                    autoFillEnable: false,
                    textInputAction: TextInputAction.done,
                    otpPinFieldStyle: OtpPinFieldStyle(
                      defaultFieldBorderColor: Colors.black,
                      filledFieldBorderColor: Theme.of(context).primaryColor,
                    ),
                    onSubmit: (text) {},
                    onChange: (text) {
                      setState(() {
                        otp = text;
                      });
                    },
                    onCodeChanged: (code) {},
                    maxLength: 6,
                    showCursor: true,
                    showDefaultKeyboard: true,
                    cursorWidth: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      sendOTP(widget.email, otp);
                      print(otp);
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
                      "Continue",
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
