import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:javascript/presentation/screens/profile/edit_profile.dart';
import 'package:javascript/presentation/screens/profile/settings/buy_code_coins.dart';
import 'package:javascript/presentation/screens/profile/settings/change_password.dart';
import 'package:javascript/presentation/screens/profile/settings/my_targets.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

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
          "Settings",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/background/settings.png"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                  child: Text(
                    "GENERAL SETTINGS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()),
                        );
                      },
                      child: Barbuilder(
                        leadingIcon: Icons.border_color_outlined,
                        text: "Edit profile",
                        trailingIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuyCoins()),
                        );
                      },
                      child: Barbuilder2(
                        leadingIcon: SvgPicture.asset(
                          "assets/svg/database.svg",
                          height: 20,
                          width: 20,
                        ),
                        text: "Buy Code Coins",
                        trailingIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyTargets()),
                        );
                      },
                      child: Barbuilder2(
                        leadingIcon: SvgPicture.asset(
                          "assets/svg/target.svg",
                          height: 20,
                          width: 20,
                        ),
                        text: "My Targets",
                        trailingIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Barbuilder(
                      leadingIcon: Icons.notifications_outlined,
                      text: "Push Notifications",
                      trailingIcon: Icons.toggle_on_rounded,
                    ),
                    Barbuilder(
                      leadingIcon: Icons.dark_mode_outlined,
                      text: "Dark Theme",
                      trailingIcon: Icons.toggle_on_rounded,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassword()),
                        );
                      },
                      child: Barbuilder2(
                        leadingIcon: SvgPicture.asset(
                          "assets/svg/encrypted.svg",
                          height: 20,
                          width: 20,
                        ),
                        text: "Change Password",
                        trailingIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Login()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0XFFF1F1F1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..scale(-1.0, 1.0),
                                    child: SvgPicture.asset(
                                      "assets/svg/move_item.svg",
                                      height: 20,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Barbuilder extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final IconData trailingIcon;

  Barbuilder({
    required this.leadingIcon,
    required this.text,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0XFFF1F1F1),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                leadingIcon,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(text),
              const Spacer(),
              Icon(
                trailingIcon,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Barbuilder2 extends StatelessWidget {
  final Widget leadingIcon;
  final String text;
  final IconData trailingIcon;

  Barbuilder2({
    required this.leadingIcon,
    required this.text,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0XFFF1F1F1),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              leadingIcon,
              const SizedBox(width: 8),
              Text(text),
              const Spacer(),
              Icon(
                trailingIcon,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
