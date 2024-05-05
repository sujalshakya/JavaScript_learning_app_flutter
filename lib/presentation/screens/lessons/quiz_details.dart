import 'dart:async';

import 'package:flutter/material.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class QuizDetails extends StatefulWidget {
  final String question;
  final String? correctAnswer;
  final List options;
  const QuizDetails({
    Key? key,
    required this.question,
    required this.correctAnswer,
    required this.options,
  }) : super(key: key);

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  int _timerValue = 60;
  late Timer _timer;
  int? _selectedOptionIndex;
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
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      childAspectRatio: 2.10,
    );
    Color resultColor = Colors.white;
    String resultText = "";
    if (_selectedOptionIndex != null) {
      if (widget.options[_selectedOptionIndex!] == widget.correctAnswer) {
        resultText = "Correct";
        resultColor = const Color(0XFF48CF3C);
      } else {
        resultText = "Incorrect";
        resultColor = const Color(0XFFFF4B57);
      }
    }

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
        child: SizedBox(
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
                child: LinearProgressIndicator(
                  value: _timerValue / 60,
                  backgroundColor: const Color(0x59513EDD),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF513EDD)),
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
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Question",
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
                      Row(
                        children: [
                          Text(widget.question,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  resultText.isNotEmpty
                      ? resultText
                      : "Choose the correct one:",
                  style: TextStyle(fontSize: 18, color: resultColor),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Choose the correct one:",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: gridDelegate,
                  itemCount: widget.options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOptionIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            color: _selectedOptionIndex == index
                                ? widget.options[index] == widget.correctAnswer
                                    ? const Color(0XFF48CF3C)
                                    : const Color(0XFFFF4B57)
                                : const Color(0XFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              widget.options[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              WideButton(
                text: "Continue",
                screenHeight: screenHeight,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
