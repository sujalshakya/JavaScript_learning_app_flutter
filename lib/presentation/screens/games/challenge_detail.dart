import 'package:flutter/material.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class ChallengeDetails extends StatefulWidget {
  const ChallengeDetails({super.key});

  @override
  State<ChallengeDetails> createState() => ChallengeDetailsState();
}

class ChallengeDetailsState extends State<ChallengeDetails> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
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
          "Challenges",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/background/quiz_circle.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          height: 40,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Question 1 ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      const Row(
                        children: [
                          Text("What is element called that",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Instructions",
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
                          "Code",
                          style: TextStyle(
                            color: Colors.grey,
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
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0XFF333F44)),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.expand_less),
                        Text("Output"),
                        Spacer(),
                        Text("Clear")
                      ],
                    )
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WideButton(
                  text: "Submit",
                  screenHeight: screenHeight,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
