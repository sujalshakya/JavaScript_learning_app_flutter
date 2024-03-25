import 'dart:async';

import 'package:flutter/material.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class QuizDetails extends StatefulWidget {
  const QuizDetails({super.key});

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  int _timerValue = 60;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_timerValue == 0) {
            timer.cancel();
          } else {
            _timerValue--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
          "Quiz",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Image.asset("assets/icons/fire.png", height: 40, width: 40),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: const LinearProgressIndicator(
                  value: 0.25,
                  backgroundColor: Color(0x59513EDD),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF513EDD)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: screenHeight * 0.25,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Question 1 ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 2),
                                child: Text(
                                  '$_timerValue',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          height: 35,
                          top: 0,
                          right: 0,
                          child: CircularProgressIndicator(
                            value: _timerValue / 60,
                            backgroundColor: Colors.white.withOpacity(0.5),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
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
              SizedBox(
                height: screenHeight * 0.1,
              ),
              const Text("Choose the correct one:"),
              Row(
                children: [
                  (Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0XFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Loop",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )),
                  (Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0XFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Loop",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  (Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0XFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Loop",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )),
                  (Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0XFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Loop",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              WideButton(text: "Next", screenHeight: screenHeight, onPressed: () {  },)
            ],
          ),
        ),
      ),
    );
  }
}
