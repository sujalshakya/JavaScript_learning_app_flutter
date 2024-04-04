import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/presentation/screens/lesson_details.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';
import 'package:http/http.dart' as http;

class AllLessons extends StatefulWidget {
  const AllLessons({super.key});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<AllLessons> {
  List<Map<String, dynamic>> lessons = [];

  @override
  void initState() {
    super.initState();
    fetchLessonData();
  }

  Future<void> fetchLessonData() async {
    final response = await http.get(Uri.parse(
        'https://api.codynn.com/api/course/65ce1a4afc25b0121865f1e5/lesson'));

    if (response.statusCode == 200) {
      final List<dynamic> lessonData = json.decode(response.body);
      setState(() {
        lessons = List<Map<String, dynamic>>.from(lessonData);
      });
    } else {
      throw Exception('Failed to load lesson data');
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
          "Java",
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "All Lessons",
                      style: AppTextStyles.headingStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.7,
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      final lessonIndex = lesson['index'];
                      return LessonTab(
                        lessonTitle: lesson['lessonTitle'],
                        lessonIndex: lessonIndex,
                        lessonid: lesson['id'],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: WideButton(
                    text: "Enroll",
                    screenHeight: screenHeight,
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LessonTab extends StatelessWidget {
  final String lessonTitle;
  final int lessonIndex;
  final String lessonid;

  const LessonTab(
      {Key,
      required this.lessonTitle,
      required this.lessonIndex,
      required this.lessonid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  LessonDetails(lessonid:lessonid, lessonTitle: lessonTitle )));
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0XFFEDEBFF)),
              child: Center(
                child: Text(
                  '${lessonIndex}',
                  style: TextStyle(color: AppConstants.primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              lessonTitle,
              style: AppTextStyles.headingStyle,
            ),
          ),
          const Spacer(),
          Transform.rotate(
              angle: -3.14 / 2, child: const Icon(Icons.arrow_back_ios))
        ],
      ),
    );
  }
}
