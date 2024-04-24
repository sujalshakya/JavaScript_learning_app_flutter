import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    check();
    super.initState();
  }

  check() async {
    var box = await Hive.openBox('SETTINGS');
    print(box.get('token'));
    if (box.get('token') != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar2(selectedIndex: 1,)),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
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
