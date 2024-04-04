import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';
import 'package:javascript/presentation/screens/all_lessons.dart';
import 'package:javascript/presentation/widgets/codecoins.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

import '../widgets/coin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JavaScript extends StatefulWidget {
  const JavaScript({super.key});

  @override
  State<JavaScript> createState() => _JavaScriptState();
}

class _JavaScriptState extends State<JavaScript> {
  List<Map<String, dynamic>> lessons = [];
  List<Map<String, dynamic>> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchLessonData();
    fetchReviewData();
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
      throw Exception(response.body);
    }
  }

  Future<void> fetchReviewData() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');
    final response = await http.get(
      Uri.parse('https://api.codynn.com/api/review'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> reviewData = responseData['getReviews'];
      setState(() {
        reviews = List<Map<String, dynamic>>.from(reviewData.take(3));
      });
    } else {
      throw Exception('Failed to load review data');
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
          "JavaScript",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.ios_share),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.78,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Container(
                            width: screenWidth,
                            height: screenHeight * 0.28,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0XFF277DA1)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Programming",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Coin(text: ""),
                                            Text(
                                              "+50",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.04,
                                ),
                                const Text(
                                  "Java",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "12 lessons",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "2 hours",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.04,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        "4.6",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            height: 250,
                            width: 100,
                            left: -15,
                            top: 85,
                            child: Image.asset("assets/icons/books.png"),
                          ),
                        ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Description",
                          style: AppTextStyles.headingStyle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("description"),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Skills you will gain",
                          style: AppTextStyles.headingStyle,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0XFFF5F5F5),
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Programming",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0XFFF5F5F5),
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Programming",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0XFFF5F5F5),
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Programming",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0XFFF5F5F5),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: AppConstants.primaryColor,
                              width: 1.0,
                            )),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                              ),
                              Text(
                                "Rs 2400",
                                style: AppTextStyles.headingStyle,
                              ),
                              Spacer(),
                              Icon(Icons.check),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0XFFF5F5F5),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CodeCoin(),
                              Text(
                                "200 Code Coins",
                                style: AppTextStyles.headingStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Lessons",
                          style: AppTextStyles.headingStyle,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.4,
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: lessons.length > 6 ? 6 : lessons.length,
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
                              final lessonIndex = lesson['index'];
                              return LessonTab(
                                lessonTitle: lesson['lessonTitle'],
                                lessonIndex: lessonIndex,
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllLessons()));
                            },
                            child: const Text(
                              "+ more",
                              style:
                                  TextStyle(color: AppConstants.primaryColor),
                            ),
                          ),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Top Reviews",
                              style: AppTextStyles.headingStyle,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.6,
                        child: ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return Review(
                              reviewStar: review['reviewStar'],
                              reviewComment: review['reviewComment'],
                            );
                          },
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: WideButton(
                  text: "Enroll", screenHeight: screenHeight, onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String reviewComment;

  final int reviewStar;

  const Review({
    super.key,
    required this.reviewComment,
    required this.reviewStar,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('path_to_your_image'),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("name"),
                  Text(
                    "date",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF808080),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  reviewStar.toString(),
                  style: const TextStyle(color: Colors.yellow, fontSize: 18),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) {
                    if (index < reviewStar) {
                      return const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      );
                    } else {
                      return const Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(reviewComment),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class LessonTab extends StatelessWidget {
  final String lessonTitle;
  final int lessonIndex;

  const LessonTab({
    super.key,
    Key,
    required this.lessonTitle,
    required this.lessonIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                style: const TextStyle(color: AppConstants.primaryColor),
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
    );
  }
}
