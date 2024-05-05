import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/models/profile_model.dart';
import 'package:javascript/presentation/screens/javascript.dart';
import 'package:javascript/presentation/widgets/drawer.dart';
import 'package:http/http.dart' as http;

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
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

    print(response.body);
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        elevation: 0,
        title: const Text(
          'Courses',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        iconTheme: const IconThemeData(
          color: Color(0xFF644AFF),
        ),
        actions: <Widget>[
          FutureBuilder<ProfileModel>(
            future: getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final profile = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: profile.profile.profilePicture != null
                        ? NetworkImage(profile.profile.profilePicture!)
                        : null,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0XFFF5F5F5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(children: [Icon(Icons.search), Text("Search")]),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppConstants.primaryColor),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Text(
                                  "All",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color(0XFFF5F5F5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Text(
                                "Design",
                                style: AppTextStyles.headingStyle,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0XFFF5F5F5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Text(
                                  "Programming",
                                  style: AppTextStyles.headingStyle,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0XFFF5F5F5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Text(
                                  "Java",
                                  style: AppTextStyles.headingStyle,
                                ),
                              )),
                        )
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Courses",
                        style: AppTextStyles.headingStyle,
                      ),
                      Text(
                        "View all",
                        style: TextStyle(color: AppConstants.primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const JavaScript()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(children: [
                              Container(
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0XFF277DA1)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(32)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Programming",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.04,
                                    ),
                                    const Text(
                                      "Java",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "12 lessons",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.04,
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                height: 200,
                                width: 70,
                                left: -15,
                                top: 64,
                                child: Image.asset("assets/icons/halfbook.png"),
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Container(
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0XFFF9C74F)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Design",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.04,
                                  ),
                                  const Text(
                                    "UI UX",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "12 lessons",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.04,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              height: 200,
                              width: 70,
                              left: -15,
                              top: 64,
                              child: Image.asset("assets/icons/halfbook.png"),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Video Courses",
                      style: AppTextStyles.headingStyle,
                    ),
                    Text(
                      "View all",
                      style: TextStyle(color: AppConstants.primaryColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(children: [
                        Container(
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0XFF43AA8B)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Programming",
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              const Text(
                                "JavaScript",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "2 hours",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          height: 250,
                          width: 100,
                          left: -30,
                          top: 24,
                          child: Image.asset("assets/icons/books.png"),
                        ),
                      ]),
                    ),
                  ],
                )
              ],
            )),
      ),
      drawer: MyDrawer(),
    );
  }
}
