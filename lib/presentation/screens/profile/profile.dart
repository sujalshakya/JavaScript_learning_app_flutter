import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/presentation/screens/profile/edit_profile.dart';
import 'package:javascript/presentation/screens/profile/leaderboard.dart';
import 'package:javascript/presentation/screens/profile/settings/my_certificates.dart';
import 'package:javascript/presentation/screens/profile/settings/my_targets.dart';
import 'package:javascript/presentation/screens/profile/settings/settings.dart';
import 'package:javascript/presentation/widgets/codecoins.dart';
import 'package:javascript/presentation/widgets/coin.dart';
import 'package:javascript/presentation/widgets/drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          'My Profile',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        iconTheme: const IconThemeData(
          color: Color(0xFF644AFF),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
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

              return Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: const CircleAvatar(
                                backgroundColor: AppConstants.primaryColor,
                                radius: 50,
                                backgroundImage: AssetImage(''),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    profile?.profile.username ??
                                        'No username available',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 8.0),
                                  child: Text(
                                    profile?.profile.email ??
                                        'No email available',
                                    style: const TextStyle(
                                        color: Color(0XFF595959)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfile(profile: profile)),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppConstants.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Edit Profile",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.border_color_outlined,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                Text("Total Code Points"),
                                Row(
                                  children: [
                                    Coin(text: 'CP'),
                                    Text(
                                      "400",
                                      style: TextStyle(
                                          color: AppConstants.primaryColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Total Code Coins"),
                                Row(
                                  children: [
                                    const CodeCoin(),
                                    Text(
                                      "${profile.profile.coins}",
                                      style: const TextStyle(
                                          color: AppConstants.primaryColor),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About me",
                              style: AppTextStyles.headingStyle,
                            ),
                          ],
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
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: const Color(0XFFF5F5F5)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Active",
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
                                          horizontal: 16, vertical: 8),
                                      child: Text(
                                        "Design",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: AppConstants.primaryColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Add more +",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                )
                              ]),
                        ),
                        const Padding(
                            padding: EdgeInsets.all(8.0), child: Text("Bio")),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Leaderboard(),
                                ));
                          },
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.13,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/background/profile_leaderboard.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(16)),
                            child: const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.leaderboard_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text("Leaderboard Status",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text("#56 rank",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.17,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/background/profile_progress.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Your Progress",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.42,
                                      ),
                                      const Text("75%",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(children: [
                                    Text("15 lessons covered.",
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text("16 questions solved.",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyTargets()));
                          },
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.14,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/background/profile_target.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SvgPicture.asset(
                                          "assets/svg/target.svg",
                                          color: Colors.white,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const Text("My Targets",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyCertificates()),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.14,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/background/profile_certificates.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SvgPicture.asset(
                                          "assets/svg/graduation.svg",
                                          color: Colors.white,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const Text("My Certificates",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
      drawer: MyDrawer(),
    );
  }
}
