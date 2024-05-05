// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/models/profile_model.dart';
import 'package:javascript/presentation/screens/profile/profile.dart';

import 'package:javascript/presentation/widgets/widebutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel profile;
  const EditProfile({super.key, required this.profile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProfileModel profile;

  bool isLoading = false;
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController dateOfBirthController;
  late TextEditingController phoneNumberController;

  File? _image;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.profile.profile.username ?? '');
    bioController =
        TextEditingController(text: widget.profile.profile.bio ?? '');
    dateOfBirthController =
        TextEditingController(text: widget.profile.profile.dateofbirth ?? '');
    phoneNumberController =
        TextEditingController(text: widget.profile.profile.phoneNumber ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> updateProfile(
    String name,
    String bio,
    String dateOfBirth,
    String phoneNumber,
    String? imageUrl,
  ) async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> requestBody = {
      'username': name,
      'bio': bio,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
    };
    if (imageUrl != null) {
      requestBody['profile_picture'] = imageUrl;
    }
    final response = await http.patch(
      Uri.parse("https://api.codynn.com/api/profile/user"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully!'),
        ),
      );
      Navigator.pop(context, true);
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
        ),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
//cloudinary url and preset needs to be changed
      if (_image != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.cloudinary.com/v1_1/doz26xia5/image/upload'),
        )
          ..fields['upload_preset'] = 'n01rilm1'
          ..files.add(await http.MultipartFile.fromPath('file', _image!.path));

        final response = await request.send();


        if (response.statusCode == 200) {
          final responseBody = await response.stream.toBytes();
          final jsonResponse = String.fromCharCodes(responseBody);
          final jsonMap = jsonDecode(jsonResponse);
          if (mounted) {
            setState(() {
              imageUrl = jsonMap['url'];
            });
          }
        } else if (response.statusCode == 400) {
        } else {}
      }
    } else {}
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
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: _getImage,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color(0XFF9B8AFF).withOpacity(0.8),
                            radius: 60,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null ? null : null,
                          ),
                        ),
                      ),
                      if (_image == null)
                        Positioned(
                          top: 70,
                          left: 78,
                          child: Container(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: const CircleAvatar(
                                backgroundColor: Color(0XFF9B8AFF),
                                radius: 25,
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Color.fromARGB(255, 10, 8, 8),
                                ),
                              )),
                        )
                    ],
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Full Name",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(
                        text: widget.profile.profile.email),
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: 'email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: 'no',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: dateOfBirthController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "About me",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                      prefixText: '  ',
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 32),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WideButton(
                  text: "Save",
                  screenHeight: screenHeight,
                  onPressed: () async {
                    await _getImage();
                    updateProfile(
                      nameController.text,
                      bioController.text,
                      dateOfBirthController.text,
                      phoneNumberController.text,
                      imageUrl,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
