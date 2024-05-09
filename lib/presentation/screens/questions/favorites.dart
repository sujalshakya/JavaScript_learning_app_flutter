import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/models/question_model.dart';
import 'package:javascript/presentation/screens/questions/questions_details.dart';
import 'package:http/http.dart' as http;

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<String> favoriteIds = [];
  late List<QuestionModel> questions = [];
  dynamic response;

  @override
  void initState() {
    super.initState();
    getFavorite();
    fetchQuestions();
  }

  void deleteFavorite(String questionId) async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    http.Response httpResponse =
        await http.delete(Uri.parse('https://api.codynn.com/api/favourites'),
            headers: <String, String>{
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
              <String, String>{"question": questionId},
            ));
    setState(() {
      if (httpResponse.statusCode == 200) {
        setState(() {
          favoriteIds.remove(questionId);
        });
        const SnackBar(content: Text("deleted"));
      } else {
      }
    });
  }

  void getFavorite() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    http.Response httpResponse = await http.get(
      Uri.parse('https://api.codynn.com/api/favourites'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    setState(() {
      if (httpResponse.statusCode == 200) {
        var data = jsonDecode(httpResponse.body);
        List<dynamic> questions = data['UserFavourites']['question'];
        favoriteIds = questions.map((q) => q['id'].toString()).toList();
      } else {
      }
    });
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.codynn.com/api/question?language=javascript&limit=1000'));

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
      }
    } catch (e) {
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
          "Favorites",
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
                SizedBox(
                    height: screenHeight * 0.8,
                    child: ListView.builder(
                      itemCount: favoriteIds.length,
                      itemBuilder: (context, index) {
                        final favoriteId = favoriteIds[index];

                        final question = questions.firstWhere(
                          (q) => q.id == favoriteId,
                          orElse: () => QuestionModel(
                            question: '',
                            algorithm: '',
                            explanation: '',
                            flowchart: '',
                            code: '',
                            id: '',
                          ),
                        );

                        return QuestionTab(
                          index: index,
                          question: question.question,
                          algorithm: question.algorithm,
                          explanation: question.explanation,
                          flowchart: question.flowchart,
                          code: question.code,
                          id: question.id,
                          onDelete: () {
                            deleteFavorite(question.id);
                          },
                        );
                      },
                    )),
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
  final VoidCallback onDelete;

  const QuestionTab({
    Key? key,
    this.question,
    this.algorithm,
    this.flowchart,
    this.code,
    required this.index,
    this.explanation,
    this.id,
    required this.onDelete,
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
                id: id),
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
                    question ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    onDelete();
                  },
                  child: const Icon(Icons.delete_outline))
            ],
          ),
        ],
      ),
    );
  }
}
