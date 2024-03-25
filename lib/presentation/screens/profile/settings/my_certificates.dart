import 'package:flutter/material.dart';
import 'package:javascript/constants/text_style.dart';

class MyCertificates extends StatelessWidget {
  const MyCertificates({super.key});

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
            "My Certificates",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Date",
                            style: AppTextStyles.headingStyle,
                          ),
                          Spacer(),
                          Icon(Icons.file_download_outlined),
                          Icon(Icons.ios_share)
                        ],
                      ),
                      Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/background/certificate.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.6,
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.06,
                              ),
                              const Text(
                                "Certificate of Completion",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "We would like to congratulate",
                                style: TextStyle(fontSize: 8),
                              ),
                              const Text(
                                "Mr. Aaron Smith",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: screenWidth * 0.5,
                                child: const Text(
                                  "for successfully completing the Java course on 12/12/2024. We wish you all the best for your future endeavors.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]))));
  }
}
