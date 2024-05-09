import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/models/profile_model.dart';
import 'package:javascript/presentation/screens/daily_streak.dart';
import 'package:javascript/presentation/screens/data_structures.dart';
import 'package:javascript/presentation/screens/questions/questions.dart';
import 'package:javascript/presentation/screens/questions/questions_details.dart';
import 'package:javascript/presentation/widgets/bottom_nav_bar.dart';
import 'package:javascript/presentation/widgets/drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:javascript/models/question_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProfileModel profile;
  bool isLoading = true;

  late List<QuestionModel> questions = [];
  @override
  void initState() {
    super.initState();
    getProfile();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.codynn.com/api/question?language=javascript&page=1&limit=100'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

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
      } else {}
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> postCode(String code) async {
    final response = await http.post(
      Uri.parse('https://compiler.codynn.com/api/run'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code,
        'language': 'javascript',
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final output = responseData['output'];

      return true;
    }
    return false;
  }

  Future<ProfileModel>? getProfile() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    final response = await http.get(
      Uri.parse("https://api.codynn.com/api/profile/user"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    int date = DateTime.now().day;
    int month = DateTime.now().month;

    int random = ((month + 1) * date) ~/ 2;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        iconTheme: const IconThemeData(
          color: Color(0xFF644AFF),
        ),
        actions: <Widget>[
          FutureBuilder<ProfileModel>(
            future: getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final profile = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: profile.profile.profilePicture != null
                        ? NetworkImage(profile.profile.profilePicture!)
                        : null,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenWidth * 0.9,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyStreak()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0XFFFFB400),
                    ),
                    height: screenHeight * 0.1,
                    child: Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Text(
                                'Daily streak',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text('Day 2',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        Image.asset('assets/icons/fire.png'),
                        SizedBox(
                          width: screenWidth * 0.22,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const BottomNavBar2(selectedIndex: 1)),
                );
              },
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image:
                        AssetImage('assets/background/background_image1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                          child: Text(
                            'JavaScript Course',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                          child: Text(
                            '75%',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    UnconstrainedBox(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: const LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: Color(0x40FFFFFF),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Text("where you left",
                                  style: TextStyle(color: Colors.white)),
                            )
                          ]),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SizedBox(
                    child: Text(
                      "Console based programs",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Questions(category: "Series")));
                          },
                          child: const Card(text: "Series"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Questions(
                                        category: "Numerical")));
                          },
                          child: const Card(text: "Numerical"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Questions(category: "Pattern")));
                          },
                          child: const Card(text: "Pattern"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Questions(
                                        category: "Conversion")));
                          },
                          child: const Card(text: "Conversion"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Questions(category: "Basic")));
                          },
                          child: const Card(text: "Basic Programs"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Questions(category: "Loop")));
                          },
                          child: const Card(text: "Looping"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Questions(
                                        category: "Conditional")));
                          },
                          child: const Card(text: "Conditional Statement"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Questions(
                                        category: "String Manipulation")));
                          },
                          child: const Card(text: "String Manipulation"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SizedBox(
                    child: Text(
                      "Data Structures",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 0, 32, 0),
                  child: Column(
                    children: [
                      const Text(
                        "Built-in",
                        style: TextStyle(
                          color: Color(0xFF644AFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF644AFF),
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(top: 4.0),
                        height: 4.0,
                        width: 20.0,
                      ),
                    ],
                  ),
                ),
                const Text("User-defined"),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DataStructures(
                              index: 0,
                            )));
              },
              child: SizedBox(
                width: screenWidth * 0.9,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: screenWidth * 0.42,
                        height: screenHeight * 0.09,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/background/list_background.png'),
                            fit: BoxFit.fill,
                          ),
                          color: const Color(0XFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 28, 0, 0),
                          child: Text(
                            "Lists",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataStructures(
                                      index: 1,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: screenWidth * 0.42,
                          height: screenHeight * 0.09,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/background/dictionary_background.png'),
                              fit: BoxFit.fill,
                            ),
                            color: const Color(0XFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 28, 0, 0),
                            child: Text(
                              "Dictionary",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataStructures(
                                    index: 2,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: screenWidth * 0.42,
                        height: screenHeight * 0.09,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/background/tuples_background.png'),
                            fit: BoxFit.fill,
                          ),
                          color: const Color(0XFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 28, 0, 0),
                          child: Text(
                            "Tuples",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DataStructures(index: 3)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: screenWidth * 0.42,
                        height: screenHeight * 0.09,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/background/sets_background.png'),
                            fit: BoxFit.fill,
                          ),
                          color: const Color(0XFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 28, 0, 0),
                          child: Text(
                            "Sets",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SizedBox(
                    child: Text(
                      "Simple Script",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                  child: Text(
                    "View all",
                    style: TextStyle(color: Color(0xFF644AFF)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.9,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final question = questions[random];
                        random++;
                        random++;

                        return Script(
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
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SizedBox(
                    child: Text(
                      "Advanced Data Structure",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF644AFF),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Iconsax.box_search,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                        child: Text(
                          "Rename files",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0, 8, 8),
                          child: Text(
                            "Solve this problem",
                            style: TextStyle(
                                color: Color(
                                  0XFF737373,
                                ),
                                fontSize: 12),
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF644AFF),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Iconsax.sort,
                      color: Colors.white,
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                        child: Text(
                          "Rename files",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0, 8, 8),
                          child: Text(
                            "Solve this problem",
                            style: TextStyle(
                                color: Color(
                                  0XFF737373,
                                ),
                                fontSize: 12),
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset("assets/background/banner.png")
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class Script extends StatelessWidget {
  final String? question;
  final String? algorithm;
  final String? explanation;
  final String? flowchart;
  final String? code;
  final String? id;
  final int index;
  const Script({
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: screenHeight * 0.1,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: const Color(0XFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Solve this problem",
                    style: TextStyle(
                        color: Color(
                          0XFF737373,
                        ),
                        fontSize: 12),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String text;

  const Card({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          color: const Color(0XFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
