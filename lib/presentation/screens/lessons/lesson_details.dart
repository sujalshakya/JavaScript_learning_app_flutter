import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/presentation/screens/lessons/fill_blanks.dart';
import 'package:javascript/presentation/screens/lessons/quiz_details.dart';

class LessonDetails extends StatefulWidget {
  final String lessonid;
  final String lessonTitle;
  final int lessonIndex;

  const LessonDetails(
      {super.key,
      required this.lessonid,
      required this.lessonTitle,
      required this.lessonIndex});

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;
  List<Map<dynamic, dynamic>> course = [];
  Offset _imageOffset = Offset.zero;
  List<Map<String, dynamic>> lessons = [];
  Color selectedOptionColor = Colors.black;
  String selectedOption = '';
  final int _currentBlockIndex = 0;
  @override
  void initState() {
    super.initState();
    fetchCourseData();
    fetchLessonData();

    _scrollController.addListener(_updateProgress);
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

  void _updateProgress() {
    double progress = _scrollController.position.pixels /
        _scrollController.position.maxScrollExtent;

    progress = progress.clamp(0.0, 1.0);

    setState(() {
      _progress = progress;
      _imageOffset = Offset(_progress * 350 * 0.9, 0);
    });
  }

  Future<void> fetchCourseData() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    if (token != null) {
      final String lessonDataKey = 'courseData_${widget.lessonid}';

      if (!box.containsKey(lessonDataKey)) {
        final response = await http.get(
          Uri.parse(
              'https://api.codynn.com/api/course/65ce1a4afc25b0121865f1e5/lesson/${widget.lessonid}/chapter'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> courseData = json.decode(response.body);
          setState(() {
            course = List<Map<dynamic, dynamic>>.from(courseData);
            box.put(lessonDataKey, courseData);
          });
        } else {
          throw Exception('${response.statusCode} ${response.body}');
        }
      } else {
        final List<dynamic> courseData = box.get(lessonDataKey);
        setState(() {
          course = List<Map<dynamic, dynamic>>.from(courseData);
        });
      }
    } else {
      throw Exception('Token not found in Hive box');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          "Javascript",
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
                children: [
                  Transform.translate(
                    offset: _imageOffset,
                    child: Image.asset("assets/icons/fire.png",
                        height: 40, width: 40),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: const Color(0x59513EDD),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF513EDD)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
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
                          widget.lessonIndex.toString(),
                          style:
                              const TextStyle(color: AppConstants.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.lessonTitle,
                      style: AppTextStyles.headingStyle,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    final chapter = course[_currentBlockIndex];
                    final content = chapter['content'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (content != null)
                          for (final contentItem in content)
                            if (contentItem['text'] != null &&
                                contentItem['text']['blocks'] != null)
                              ...contentItem['text']['blocks']
                                  .map<Widget>((block) {
                                if (block['type'] == 'paragraph') {
                                  final textData = block['data'] != null &&
                                          block['data']['text'] != null
                                      ? block['data']['text']
                                      : '';
                                  if (textData.startsWith('<b>') &&
                                      textData.endsWith('</b>')) {
                                    final boldText = textData.substring(
                                        3, textData.length - 4);
                                    return ListTile(
                                      title: Text(
                                        boldText,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      title: Text(textData),
                                    );
                                  }
                                } else if (block['type'] == 'extraCues') {
                                  final cueType = block['data']['cueType'];
                                  final cueInfo = block['data']['cueInfo'];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                          color: const Color(0x33FFCE00),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color(0XFFFFCE00),
                                              width: 2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 16.0, 0, 0),
                                            child: Text(
                                              cueType,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 8.0, 16.0),
                                            child: Text(
                                              cueInfo,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (block['type'] == 'code') {
                                  final codeData = block['data'] != null &&
                                          block['data']['code'] != null
                                      ? block['data']['code']
                                      : '';
                                  return ListTile(
                                    title: Text(codeData),
                                  );
                                } else if (block['type'] == 'MCQs') {
                                  final question = block['data']['question'];
                                  final options = block['data']['options'];
                                  final correctAnswer =
                                      block['data']['correctAns'];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizDetails(
                                                  question: question,
                                                  correctAnswer: correctAnswer,
                                                  options: options,
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                            color: const Color(0x33FFCE00),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: const Color(0XFFFFCE00),
                                                width: 2)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Start Quiz!"),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (block['type'] == 'fillInTheBlanks') {
                                  final question = block['data']['question'];
                                  final option = block['data']['options'];
                                  final placeholder =
                                      block['data']['placeholder'];
                                  final answer = block['data']['answer'];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FillBlanks(
                                                  question: question,
                                                  answer: answer,
                                                  placeholder: placeholder,
                                                  option: option,
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                            color: const Color(0x33FFCE00),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: const Color(0XFFFFCE00),
                                                width: 2)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              Text("Answer Fill in The Blanks"),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (block['type'] == 'list') {
                                  final List<dynamic>? items =
                                      block['data'] != null &&
                                              block['data']['items'] != null
                                          ? block['data']['items']
                                          : null;
                                  if (items != null) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (final item in items)
                                          ListTile(
                                            title: Text(item),
                                          ),
                                      ],
                                    );
                                  }
                                }
                                return const SizedBox.shrink();
                              }).toList(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
