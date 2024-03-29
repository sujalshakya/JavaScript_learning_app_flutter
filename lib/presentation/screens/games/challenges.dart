import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:javascript/presentation/screens/games/challenge_detail.dart';

import 'package:javascript/presentation/widgets/coin.dart';

class ChallengeModel {
  final String question;
  final int complexity;
  final String instruction;

  ChallengeModel(
      {required this.question,
      required this.complexity,
      required this.instruction});

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      question: json['question'],
      complexity: json['complexity'],
      instruction: json['instruction'].toString(),
    );
  }
}

class Challenges extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  List<ChallengeModel> challenges = [];

  @override
  void initState() {
    super.initState();
    fetchChallenges();
  }

  Future<void> fetchChallenges() async {
    final response = await http.get(
        Uri.parse('https://api.codynn.com/api/challenge?language=javascript'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      List<ChallengeModel> fetchedChallenges =
          responseData.map((data) => ChallengeModel.fromJson(data)).toList();

      setState(() {
        challenges = fetchedChallenges;
      });
      print(challenges);
    } else {
      throw Exception('Failed to load challenges');
    }
  }

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
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage("assets/background/challenges.png"),
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
                      height: screenHeight * 0.2,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Challenges",
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
                  Container(
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.040,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppConstants.primaryColor)),
                    child: DropdownButton<String>(
                      value: 'Difficulty',
                      onChanged: (String? newValue) {},
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(12),
                      style: const TextStyle(color: AppConstants.primaryColor),
                      dropdownColor: Colors.white,
                      items: <String>['Difficulty', 'Easy', 'Medium', 'Hard']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Container(
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.040,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppConstants.primaryColor)),
                    child: DropdownButton<String>(
                      value: 'Category',
                      onChanged: (String? newValue) {},
                      elevation: 16,
                      underline: Container(),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      style: const TextStyle(color: AppConstants.primaryColor),
                      dropdownColor: Colors.white,
                      items: <String>['Category', 'Easy', 'Medium', 'Hard']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: challenges.length,
                  itemBuilder: (context, index) {
                    return ChallengeTab(
                      challenge: challenges[index],
                      index: index,
                      instruction: challenges[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChallengeTab extends StatelessWidget {
  final ChallengeModel challenge;
  final int index;
  final ChallengeModel instruction;
  const ChallengeTab({
    required this.challenge,
    required this.index,
    required this.instruction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String questionNumber = 'Question ${index + 1}';
    String difficultyText = '';
    Color difficultyColor = Colors.white;

    switch (challenge.complexity) {
      case 1:
        difficultyText = 'Easy';
        difficultyColor = Colors.green;
        break;
      case 2:
        difficultyText = 'Medium';
        difficultyColor = Colors.yellow;
        break;
      case 3:
        difficultyText = 'Hard';
        difficultyColor = Colors.red;
        break;
      case 4:
        difficultyText = 'Very Hard';
        difficultyColor = Colors.purple;
        break;
      default:
        difficultyText = 'Unknown';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
            color: const Color(0XFF333F44),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionNumber,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                _trimText(challenge.question),
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    difficultyText,
                    style: TextStyle(color: difficultyColor),
                  ),
                  SizedBox(
                    width: 64,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChallengeDetails(
                                  question: challenge.question,
                                  index: index,
                                  instruction: challenge.instruction)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF644AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text("Start"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _trimText(String text) {
    if (text.length > 100) {
      return text.substring(0, 100) + '...';
    }
    return text;
  }
}