import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          "Notifications",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: screenWidth * 0.9,
          child: const SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New",
                    style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Streak reminder",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 28,
                      ),
                      Text(
                        "Complete a lesson or engage in any game",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Streak reminder",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 28,
                      ),
                      Text(
                        "Complete a lesson or engage in any game",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Streak reminder",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "Complete a lesson or engage in any game to maintain streak.",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Yesterday",
                    style: AppTextStyles.headingStyle,
                  ),
                  StreakReminder(),
                  StreakReminder(),
                  StreakReminder(),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Date",
                    style: AppTextStyles.headingStyle,
                  ),
                  StreakReminder(),
                  StreakReminder(),
                  StreakReminder(),
                ]),
          ),
        ),
      ),
    );
  }
}

class StreakReminder extends StatelessWidget {
  const StreakReminder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 12,
              color: Colors.grey,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "Streak reminder",
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SizedBox(
              width: 28,
            ),
            Text(
              "Complete a lesson or engage in any game.",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ],
    ));
  }
}
