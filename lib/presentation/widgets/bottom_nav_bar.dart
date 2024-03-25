import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:javascript/presentation/screens/course.dart';
import 'package:javascript/presentation/screens/games/games.dart';
import 'package:javascript/presentation/screens/home.dart';
import 'package:javascript/presentation/screens/profile/profile.dart';

class BottomNavBar2 extends StatefulWidget {
  const BottomNavBar2({Key? key});

  @override
  State<BottomNavBar2> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar2> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Home(),
          Course(),
          Games(),
          Profile(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF644AFF),
        unselectedItemColor: Colors.black,
        elevation: 48,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home.svg',
              height: 28,
              width: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/book.svg',
              height: 28,
              width: 28,
            ),
            label: 'Course',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.extension_outlined),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/profile.svg',
              height: 28,
              width: 28,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
