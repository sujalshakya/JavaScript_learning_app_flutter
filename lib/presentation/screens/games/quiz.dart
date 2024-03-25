import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/presentation/widgets/coin.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

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
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage("assets/background/quiz.png"),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                                borderRadius: BorderRadius.circular(32)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Coin(text: "CP"),
                                Text(
                                  "+50",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.15,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Quiz",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Row(
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Choose difficulty",
                    style: AppTextStyles.headingStyle,
                  ),
                  SizedBox(width: screenWidth * 0.34),
                  Container(
                    height: screenHeight * 0.040,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppConstants.primaryColor)),
                    child: DropdownButton<String>(
                      value: 'Easy',
                      onChanged: (String? newValue) {},
                      icon: const Icon(Icons.arrow_drop_up),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(12),
                      style: const TextStyle(color: AppConstants.primaryColor),
                      dropdownColor: Colors.white,
                      items: <String>['Easy', 'Medium', 'Hard']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text(
                "Overview",
                style: AppTextStyles.headingStyle,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text(
                  "A quiz where you have to choose a correct answer among four given multiple choices. This game is worth 25 points."),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text("Time limit", style: AppTextStyles.headingStyle),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text("60 secs for each question."),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              RichText(
                text: const TextSpan(
                  style: AppTextStyles.headingStyle,
                  children: [
                    TextSpan(
                      text: "Note",
                    ),
                    TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text(
                  "You have to get at least 7 out of 10 questions correct to achieve the points."),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              WideButton(text: "Start", screenHeight: screenHeight, onPressed: () {  },)
            ],
          ),
        ),
      ),
    );
  }
}
