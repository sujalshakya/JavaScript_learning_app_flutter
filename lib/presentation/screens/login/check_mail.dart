import 'package:flutter/material.dart';

class CheckMail extends StatelessWidget {
  final String email;

  const CheckMail({Key? key, required this.email}) : super(key: key);

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
          width: screenWidth * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x14644AFF),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                height: screenHeight * 0.15,
                width: screenWidth * 0.3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0x14644AFF),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Image.asset(
                      'assets/icons/mail.png',
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.07),
              const Text(
                "Check Your Mail",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF644AFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.040),
              const Text(
                "We have sent a password recovery instructions to reset your password.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: screenHeight * 0.08),
              SizedBox(
                width: screenWidth * 0.45,
                height: screenHeight * 0.063,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF644AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                  child: const Text("Open Email"),
                ),
              ),
              SizedBox(height: screenHeight * 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't recieve email?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Send again",
                      style: TextStyle(color: Color(0xFF644AFF)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
