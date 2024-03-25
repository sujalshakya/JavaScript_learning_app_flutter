import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/presentation/widgets/coin.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class DailyStreak extends StatelessWidget {
  DailyStreak({key}) : super(key: key);
  int streakCount = 7;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<Widget> fire = List.generate(
      7,
      (index) {
        bool isStreakDay = index < streakCount;
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.width / 8,
              child: Image.asset(
                isStreakDay
                    ? 'assets/icons/fire.png'
                    : 'assets/icons/pale_fire.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              days[index],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );

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
          "Daily Streak",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Center(child: Image.asset("assets/icons/fire.png")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$streakCount Days Streak",
              style: const TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: fire,
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          SizedBox(
            width: screenWidth * 0.85,
            child: const Center(
              child: Text(
                  "Complete one lesson or participate in any one activity to maintain daily streak and win extra points."),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.07,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Coin(
                text: "SP",
              ),
              Text(
                "+points",
                style: TextStyle(color: AppConstants.primaryColor),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.07,
          ),
          streakCount < 7
              ? Container(
                  height: screenHeight * 0.080,
                  width: screenWidth,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.info_outline),
                        ),
                        Expanded(
                          child: Text(
                              "At least 7 days streak required to collect the extra points."),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: screenHeight * 0.080,
                  width: screenWidth,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/icons/firework.png"),
                        ),
                        const Expanded(
                          child: Text(
                              "Collect the extra points and appear higher in the leaderboard rankings."),
                        )
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: screenWidth * 0.9,
            child: streakCount == 7
                ? WideButton(
                    text: "Claim Points",
                    screenHeight: screenHeight,
                    onPressed: () {},
                  )
                : WideButton(
                    text: "Coninue",
                    screenHeight: screenHeight,
                    onPressed: () {},
                  ),
          )
        ],
      ),
    );
  }
}
