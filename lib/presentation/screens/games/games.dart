import 'package:flutter/material.dart';
import 'package:javascript/presentation/screens/games/challenges.dart';
import 'package:javascript/presentation/screens/games/codequest.dart';
import 'package:javascript/presentation/screens/games/quiz.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          "Games",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          const Text(
            "Codynn all star games",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          SizedBox(
            width: screenWidth * 0.6,
            child: const Text(
              "Surpass your limits and upgrade your knowledge through fun code games",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Quiz()),
              );
            },
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.18,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image:
                            AssetImage("assets/background/quiz_background.png"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Quiz",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CodeQuest()),
              );
            },
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.18,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                            "assets/background/puzzle_background.png"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "CodeQuest",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Challenges()),
              );
            },
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.18,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                            "assets/background/challenges_background.png"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Challenges",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
