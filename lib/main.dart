import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/presentation/screens/all_lessons.dart';
import 'package:javascript/presentation/screens/course.dart';
import 'package:javascript/presentation/screens/daily_streak.dart';
import 'package:javascript/presentation/screens/games/challenges.dart';
import 'package:javascript/presentation/screens/games/games.dart';
import 'package:javascript/presentation/screens/games/quiz.dart';
import 'package:javascript/presentation/screens/games/quiz_details.dart';
import 'package:javascript/presentation/screens/javascript.dart';
import 'package:javascript/presentation/screens/login/enter_otp.dart';
import 'package:javascript/presentation/screens/login/login.dart';
import 'package:javascript/presentation/screens/notifications.dart';
import 'package:javascript/presentation/screens/profile/edit_profile.dart';
import 'package:javascript/presentation/screens/profile/leaderboard.dart';
import 'package:javascript/presentation/screens/profile/profile.dart';
import 'package:javascript/presentation/screens/login/reset_password.dart';
import 'package:javascript/presentation/screens/login/signup.dart';
import 'package:javascript/presentation/screens/profile/settings/buy_code_coins.dart';
import 'package:javascript/presentation/screens/profile/settings/change_password.dart';
import 'package:javascript/presentation/screens/profile/settings/settings.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';
import 'package:javascript/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: "login",
        routes: {
          'login': (context) => Login(),
          'signup': (context) => Signup(),
          'resetpassword': (context) => ResetPassword(),
          'course': ((context) => const Course()),
          'dailystreak': ((context) => DailyStreak()),
          'notification': ((context) => const Notifications()),
          'games': (context) => const Games(),
          'quiz': (context) => const Quiz(),
          'profile': (context) => const ProfilePage(),
          'quiz_details': (context) => const QuizDetails(),
          'settings': (context) => const Settings(),
          'changepassword': (context) => const ChangePassword(),
          'buycoins': (context) => const BuyCoins(),
          'leaderboard': (context) => const Leaderboard(),
          'all_lessons': (context) => const AllLessons(),
          'bottom': (context) => const BottomNavBar2(),
          'enterOTP': (context) => const EnterOTP(
                email: '',
              ),
          'javascript': (context) => const JavaScript(),
          'challenge': (context) => const Challenges(),
        }));
  }
}
