import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.home, 'title': 'Home'},
    {'icon': Icons.settings, 'title': 'Profile'},
    {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
    {'icon': Icons.book_outlined, 'title': 'Courses'},
    {'icon': Icons.info, 'title': 'Code Questions'},
    {'icon': Icons.extension_outlined, 'title': 'Games'},
    {'icon': Icons.info, 'title': 'My Certificates'},
    {'icon': Icons.info, 'title': 'My Targets'},
    {'icon': Icons.info, 'title': 'Leaderboard'},
    {'icon': Icons.info, 'title': 'Buy code Coins'},
    {'icon': Icons.info, 'title': 'Settings'},
    {'icon': Icons.info, 'title': 'Logout'},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF644AFF),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Center(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: drawerItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        visualDensity: VisualDensity(horizontal: -4),
                        textColor: index == drawerItems.length - 1
                            ? Colors.red
                            : Colors.white,
                        leading: Icon(
                          drawerItems[index]['icon'],
                          color: index == drawerItems.length - 1
                              ? Colors.red
                              : Colors.white,
                        ),
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
                        },
                      );
                    },
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                leading: const Icon(Icons.close, color: Colors.white),
                title: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
