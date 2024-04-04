import 'package:flutter/material.dart';
import 'package:javascript/presentation/widgets/coin.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

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
          "Leaderboard",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "All time",
                    style: TextStyle(
                      color: Color(0xFF644AFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF644AFF),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(top: 4.0),
                    height: 4.0,
                    width: 20.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "This month",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(top: 4.0),
                    height: 4.0,
                    width: 20.0,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            children: [
              Container(
                height: screenHeight * 0.25,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                        image: AssetImage("assets/background/leaderboard.png"),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.064,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "#2",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('path_to_your_image'),
                              backgroundColor: Color(0XFFC0C0C0),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "Name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "points",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.012,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "#1",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('path_to_your_image'),
                              backgroundColor: Color(0XFFFFD700),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "Name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "points",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.064,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "#3",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('path_to_your_image'),
                              backgroundColor: Color(0XFFCD7F32),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "Name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                            child: Text(
                              "points",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.50,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      Ranking(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: screenHeight * 0.08,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/ranking.png")),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("#1"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('path_to_your_image'),
                        backgroundColor: Color(0XFFFFD700),
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("name"), Text("points")],
                  ),
                  const Spacer(),
                  const Coin(text: "CP"),
                  const Text("+1")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Ranking extends StatelessWidget {
  const Ranking({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight * 0.08,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
            color: const Color(0XFFF1F1F1),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("#1"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('path_to_your_image'),
                    backgroundColor: Color(0XFFFFD700),
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("name"), Text("points")],
              ),
              const Spacer(),
              const Text("+1")
            ],
          ),
        ),
      ),
    );
  }
}
