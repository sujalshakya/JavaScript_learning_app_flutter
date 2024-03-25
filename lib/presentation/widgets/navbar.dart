import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:javascript/presentation/screens/course.dart';
import 'package:javascript/presentation/screens/games/games.dart';
import 'package:javascript/presentation/screens/home.dart';
import 'package:javascript/presentation/screens/profile/profile.dart';
import 'package:javascript/presentation/widgets/bottom_navbar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<BottomNavBarCubit, BottomNavBarItem>(
      builder: (context, selectedItem) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 4,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          height: screenHeight * 0.1,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 28,
            currentIndex: BottomNavBarItem.values.indexOf(selectedItem),
            selectedItemColor: const Color(0xFF644AFF),
            unselectedItemColor: Colors.black,
            elevation: 48,
            onTap: (index) {
              final item = BottomNavBarItem.values[index];
              context.read<BottomNavBarCubit>().selectItem(item);
              switch (item) {
                case BottomNavBarItem.item1:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Home(),
                    ),
                  );
                  break;
                case BottomNavBarItem.item2:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Course(),
                    ),
                  );
                  break;
                case BottomNavBarItem.item3:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Games(),
                    ),
                  );
                  break;
                case BottomNavBarItem.item4:
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Profile(),
                    ),
                  );
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/home.svg',
                  height: 28,
                  width: 28,
                  color: selectedItem == BottomNavBarItem.item1
                      ? const Color(0xFF644AFF)
                      : Colors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/book.svg',
                  height: 28,
                  width: 28,
                  color: selectedItem == BottomNavBarItem.item2
                      ? const Color(0xFF644AFF)
                      : Colors.black,
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
                  color: selectedItem == BottomNavBarItem.item4
                      ? const Color(0xFF644AFF)
                      : Colors.black,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

