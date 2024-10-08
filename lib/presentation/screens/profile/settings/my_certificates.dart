import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:intl/intl.dart';
import 'package:javascript/models/profile_model.dart';
import 'package:http/http.dart' as http;

class MyCertificates extends StatefulWidget {
  const MyCertificates({super.key});

  @override
  State<MyCertificates> createState() => _MyCertificatesState();
}

class _MyCertificatesState extends State<MyCertificates> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          formattedDate,
                          style: AppTextStyles.headingStyle,
                        ),
                        const Spacer(),
                        const Icon(Icons.file_download_outlined),
                        const Icon(Icons.ios_share)
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
