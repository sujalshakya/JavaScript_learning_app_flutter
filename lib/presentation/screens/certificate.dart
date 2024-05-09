import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:javascript/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:javascript/presentation/widgets/widebutton.dart';

class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  late ProfileModel profile;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<ProfileModel>? getProfile() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    final response = await http.get(
      Uri.parse("https://api.codynn.com/api/profile/user"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now().toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      body: FutureBuilder<ProfileModel?>(
        future: getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final profile = snapshot.data;
            if (profile == null) {
              return const Center(child: Text('Profile data is null'));
            }
            print(profile.profile.profilePicture);
            return Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.14,
                    ),
                    const Image(
                      image: AssetImage("assets/icons/graduate.png"),
                      height: 132,
                      width: 132,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Wohoo",
                                    style: TextStyle(
                                        color: AppConstants.primaryColor,
                                        fontSize: 22),
                                  ),
                                  TextSpan(
                                    text: ", you have sucessfully ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                    const Text(
                      "completed the course.",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Here's your certificated of completion"),
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
                            Text(
                              "Mr./Ms. ${profile.profile.username}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                "for successfully completing the JavaScript course on $formattedDate. We wish you all the best for your future endeavors.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    WideButton(
                        text: "Continue",
                        screenHeight: screenHeight,
                        onPressed: () {}),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Download Certificate",
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
