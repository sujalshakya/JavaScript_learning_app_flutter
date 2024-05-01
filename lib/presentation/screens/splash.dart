// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    var box = await Hive.openBox('SETTINGS');
    if (box.get('token') != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavBar2(
                  selectedIndex: 0,
                )),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          '',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
