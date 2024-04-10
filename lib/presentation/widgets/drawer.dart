import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': SvgPicture.asset(
        'assets/svg/home.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Home'
    },
    {
      'icon': SvgPicture.asset(
        'assets/svg/profile.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Profile'
    },
    {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
    {
      'icon': SvgPicture.asset(
        'assets/svg/book.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Courses'
    },
    {'icon': Icons.quiz_outlined, 'title': 'Code Questions'},
    {'icon': Icons.extension_outlined, 'title': 'Games'},
    {
      'icon': SvgPicture.asset(
        "assets/svg/graduation.svg",
        color: Colors.white,
        height: 24,
        width: 24,
      ),
      'title': 'My Certificates'
    },
    {
      'icon': SvgPicture.asset(
        "assets/svg/target.svg",
        color: Colors.white,
        height: 24,
        width: 24,
      ),
      'title': 'My Targets'
    },
    {'icon': Icons.leaderboard_outlined, 'title': 'Leaderboard'},
    {
      'icon': SvgPicture.asset(
        'assets/svg/database.svg',
        height: 24,
        width: 24,
        color: Colors.white,
      ),
      'title': 'Buy code Coins'
    },
    {'icon': Icons.settings_outlined, 'title': 'Settings'},
    {'icon': Icons.ios_share, 'title': 'Logout'},
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
                        Navigator.pop(context);
                        Navigator.push(context, drawerItems[index]['route']);
                      },
                    );
                  },
                ),
              ),
              const Row(
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
