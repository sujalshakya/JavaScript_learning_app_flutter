import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:javascript/presentation/screens/notifications.dart';
import 'package:javascript/presentation/screens/profile/leaderboard.dart';
import 'package:javascript/presentation/screens/profile/settings/buy_code_coins.dart';
import 'package:javascript/presentation/screens/profile/settings/my_certificates.dart';
import 'package:javascript/presentation/screens/profile/settings/my_targets.dart';
import 'package:javascript/presentation/screens/profile/settings/settings.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';
import 'package:hive/hive.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': SvgPicture.asset(
        'assets/svg/home.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Home',
      'screen': const BottomNavBar2(selectedIndex: 0)
    },
    {
      'icon': SvgPicture.asset(
        'assets/svg/profile.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Profile',
      'screen': const BottomNavBar2(selectedIndex: 3)
    },
    {
      'icon': Icons.notifications_outlined,
      'title': 'Notifications',
      'screen': const Notifications()
    },
    {
      'icon': SvgPicture.asset(
        'assets/svg/book.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Courses',
      'screen': const BottomNavBar2(selectedIndex: 1)
    },
    {
      'icon': Icons.quiz_outlined,
      'title': 'Code Questions',
      'screen': const BottomNavBar2(selectedIndex: 2)
    },
    {
      'icon': Icons.extension_outlined,
      'title': 'Games',
      'screen': const BottomNavBar2(selectedIndex: 2)
    },
    {
      'icon': SvgPicture.asset(
        "assets/svg/graduation.svg",
        color: Colors.white,
        height: 24,
        width: 24,
      ),
      'title': 'My Certificates',
      'screen': const MyCertificates()
    },
    {
      'icon': SvgPicture.asset(
        "assets/svg/target.svg",
        color: Colors.white,
        height: 24,
        width: 24,
      ),
      'title': 'My Targets',
      'screen': const Target()
    },
    {
      'icon': Icons.leaderboard_outlined,
      'title': 'Leaderboard',
      'screen': const Leaderboard()
    },
    {
      'icon': SvgPicture.asset(
        'assets/svg/database.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Buy code Coins',
      'screen': const BuyCoins()
    },
    {
      'icon': Icons.settings_outlined,
      'title': 'Settings',
      'screen': const Settings()
    },
    {
      'icon': Icons.ios_share,
      'title': 'Logout',
      'screen': Login(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF644AFF),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(48.0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              Expanded(
                child: ListView.builder(
                  itemCount: drawerItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: -4),
                      textColor: index == drawerItems.length - 1
                          ? Colors.red
                          : Colors.white,
                      leading: drawerItems[index]['icon'] is IconData
                          ? drawerItems[index]['icon'] == Icons.ios_share
                              ? Transform.rotate(
                                  angle: 270 * (3.14159 / 180),
                                  child: Icon(
                                    drawerItems[index]['icon'],
                                    color: index == drawerItems.length - 1
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                )
                              : Icon(
                                  drawerItems[index]['icon'],
                                  color: index == drawerItems.length - 1
                                      ? Colors.red
                                      : Colors.white,
                                )
                          : drawerItems[index]['icon'],
                      title: Text(
                        drawerItems[index]['title'],
                        style: TextStyle(
                          color: index == drawerItems.length - 1
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToScreen(context, drawerItems[index]['screen']);
                      },
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
