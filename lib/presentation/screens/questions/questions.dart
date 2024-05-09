import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:javascript/constants/constants.dart';
import 'package:javascript/models/question_model.dart';
import 'package:javascript/presentation/screens/questions/questions_details.dart';

class Questions extends StatefulWidget {
  final String category;

  const Questions({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _QuestionTabState createState() => _QuestionTabState();
}

class _QuestionTabState extends State<Questions> {
  late List<QuestionModel> questions = [];
  late List<QuestionModel> filteredQuestions = [];
  bool isLoading = true; 

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchQuestions(widget.category);
    _search('');
  }

  void _search(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredQuestions = questions;
      } else {
        filteredQuestions = questions.where((question) {
          return question.question.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> fetchQuestions(String category) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.codynn.com/api/question?category=$category&language=javascript&page=1&limit=100'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('questions')) {
          final List<dynamic> questionsData = responseData['questions'];
          for (var data in questionsData) {
            final QuestionModel question = QuestionModel(
              question: data['question'],
              algorithm: data['algorithm'],
              explanation: data['solutions'][0]['explanation'],
              flowchart: data['flowchart'],
              code: data['solutions'][0]['code'],
              id: data['id'],
            );
            setState(() {
              questions.add(question);
            });
          }
        } else {
        }
      } else {
        print('Failed to fetch questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
    
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
      body: SizedBox(
        width: screenWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0XFFF5F5F5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            _search(value);
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          icon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.8,
                  child: ListView.builder(
                    itemCount: filteredQuestions.length,
                    itemBuilder: (context, index) {
                      final question = filteredQuestions[index];
                      return QuestionTab(
                          index: index,
                          question: question.question,
                          algorithm: question.algorithm,
                          explanation: question.explanation,
                          flowchart: question.flowchart,
                          code: question.code,
                          id: question.id);
                    },
                  ),
                ),
              ],
            ),
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
  final String? id;
  final int index;

  const QuestionTab({
    Key? key,
    this.question,
    this.algorithm,
    this.flowchart,
    this.code,
    required this.index,
    this.explanation,
    this.id,
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
              id: id,
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
                      style: const TextStyle(color: Color(0xFF644AFF)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question!,
                    style: const TextStyle(fontSize: 16),
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
