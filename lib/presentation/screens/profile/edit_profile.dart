import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';

import 'package:javascript/presentation/widgets/widebutton.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
      body: Center(
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
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 60,
                        backgroundImage: AssetImage(''),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 78,
                      child: Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: const CircleAvatar(
                            backgroundColor: AppConstants.primaryColor,
                            radius: 25,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.black,
                            ),
                          )),
                    )
                  ],
                ),
              ]),
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
                      "About me",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: TextField(
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
              WideButton(text: "Save", screenHeight: screenHeight, onPressed: () {  },)
            ],
          ),
        ),
      ),
    );
  }
}
