import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});
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
          title: const Text(
            "Change Password",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
            width: screenWidth * 0.9,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Reset your password",
                  style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Text(
                  "Your new password should be different from you previous used passwords."),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Current Password",
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
                    decoration: InputDecoration(
                        prefixText: '  ',
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: Theme(
                          data: ThemeData(
                            iconTheme: const IconThemeData(
                              color: Color(0xFF644AFF),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.visibility_off,
                              color: AppConstants.primaryColor,
                            ),
                            onPressed: () {},
                          ),
                        )),
                    obscureText: true,
                  )),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
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
                    decoration: InputDecoration(
                        prefixText: '  ',
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: Theme(
                          data: ThemeData(
                            iconTheme: const IconThemeData(
                              color: Color(0xFF644AFF),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.visibility_off,
                                color: AppConstants.primaryColor),
                            onPressed: () {},
                          ),
                        )),
                    obscureText: true,
                  )),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Confirm Password",
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
                    decoration: InputDecoration(
                        prefixText: '  ',
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: Theme(
                          data: ThemeData(
                            iconTheme: const IconThemeData(
                              color: Color(0xFF644AFF),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.visibility_off,
                                color: AppConstants.primaryColor),
                            onPressed: () {},
                          ),
                        )),
                    obscureText: true,
                  )),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              WideButton(text: "Reset", screenHeight: screenHeight, onPressed: () {  },)
            ]),
          ),
        )));
  }
}
