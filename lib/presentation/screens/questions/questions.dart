import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:http/http.dart' as http;
import 'package:javascript/presentation/screens/questions/question_model.dart';
import 'package:javascript/presentation/screens/questions/questions_details.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  _QuestionTabState createState() => _QuestionTabState();
}

class _QuestionTabState extends State<Questions> {
  late Box<QuestionModel> questionBox;

  late List<QuestionModel> questions;

  @override
  void initState() {
    super.initState();
    _initHive();
    fetchQuestions();
  }

  Future<void> _initHive() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter<QuestionModel>(QuestionModelAdapter());
    questionBox = await Hive.openBox<QuestionModel>('questions');
    setState(() {
      questions = questionBox.values.toList();
    });
  }

  Future<void> fetchQuestions() async {
    if (questionBox.isEmpty) {
      try {
        final response = await http.get(Uri.parse(
            'https://api.codynn.com/api/question?difficulty=easy&category=Basic&language=javascript&page=1&limit=10&search=number'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData.containsKey('questions')) {
            final List<dynamic> questionsData = responseData['questions'];
            for (var data in questionsData) {
              final question = QuestionModel()
                ..question = data['question']
                ..algorithm = data['algorithm']
                ..explanation = data['solutions'][0]['explanation']
                ..flowchart = data['flowchart']
                ..code = data['solutions'][0]['code'];
              questionBox.add(question);
            }
          } else {
            print(
                'Invalid response format: Questions not found in response data');
          }
        } else {
          print('Failed to fetch questions: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching questions: $e');
      }
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
          "Questions",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0XFFF5F5F5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    Icon(Icons.search),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Search"),
                    ),
                    Spacer(),
                    Icon(Icons.tune),
                  ]),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppConstants.primaryColor),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Text(
                                  "Function",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color(0XFFF5F5F5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Text(
                                "File Handling",
                                style: AppTextStyles.headingStyle,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0XFFF5F5F5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Text(
                                  "Decision Making",
                                  style: AppTextStyles.headingStyle,
                                ),
                              )),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.7,
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return QuestionTab(
                        index: index,
                        question: question.question,
                        algorithm: question.algorithm,
                        explanation: question.explanation,
                        flowchart: question.flowchart,
                        code: question.code,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionTab extends StatelessWidget {
  final String? question;
  final String? algorithm;
  final String? explanation;
  final String? flowchart;
  final String? code;

  final int index;

  const QuestionTab({
    Key? key,
    this.question,
    this.algorithm,
    this.flowchart,
    this.code,
    required this.index,
    this.explanation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionDetails(
              question: question,
              algorithm: algorithm,
              index: index,
              explanation: explanation,
              flowchart: flowchart,
              code: code,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0XFFEDEBFF),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: AppConstants.primaryColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question!,
                    style: AppTextStyles.headingStyle,
                  ),
                ),
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ],
      ),
    );
  }
}