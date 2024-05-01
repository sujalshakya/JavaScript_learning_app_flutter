import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class ChallengeDetails extends StatefulWidget {
  final int index;
  final String? question;
  final String? instruction;
  final String? id;
  final String? defaultCode;
  final List<String> testCases;
  const ChallengeDetails({
    Key? key,
    required this.index,
    required this.question,
    required this.instruction,
    required this.id,
    required this.defaultCode,
    required this.testCases,
  }) : super(key: key);

  @override
  State<ChallengeDetails> createState() => ChallengeDetailsState();
}

class ChallengeDetailsState extends State<ChallengeDetails> {
  dynamic response;
  int selectedOption = 1;
  int selectedTest = 1;
  bool isCodeVisible = true;
  late CodeController codeController;

  @override
  void initState() {
    super.initState();
    codeController = CodeController(
      text: widget.defaultCode,
      language: javascript,
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _runCode() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');
    String code = codeController.text;

    http.Response httpResponse = await http.post(
        Uri.parse('https://api.codynn.com/api/challenge/checkSolution'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{
            "challengeID": '${widget.id}',
            "code": code,
            "language": 'javascript'
          },
        ));

    setState(() {
      if (httpResponse.statusCode == 200) {
        response = jsonDecode(httpResponse.body);
      } else {
        response = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget buildOutputWidget() {
      if (response != null) {
        bool passed = response['runs'][selectedTest - 1]['passed'];

        return Container(
          width: screenWidth * 0.85,
          height: 100,
          decoration: BoxDecoration(
            color: passed ? const Color(0XFF32C100) : const Color(0XFFFF9A9A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              response['runs'][selectedTest - 1]['output_received'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        );
      } else {
        return const Text(
          'Output not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        );
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
          "Challenges",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/background/quiz_circle.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Question ${widget.index + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Expanded(
                              child: Text(widget.question ?? '',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 1;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Instructions',
                                style: TextStyle(
                                  color: selectedOption == 1
                                      ? const Color(0XFF644AFF)
                                      : const Color(0XFFA3A3A3),
                                  fontSize: 16,
                                ),
                              ),
                              selectedOption == 1
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF644AFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 4.0,
                                      width: 20.0,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 2;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Code',
                                style: TextStyle(
                                  color: selectedOption == 2
                                      ? const Color(0XFF644AFF)
                                      : const Color(0XFFA3A3A3),
                                  fontSize: 16,
                                ),
                              ),
                              selectedOption == 2
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF644AFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 4.0,
                                      width: 20.0,
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      ]),
                ),
                if (isCodeVisible && selectedOption == 2)
                  SizedBox(
                    height: screenHeight * 0.53,
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.45,
                          decoration: BoxDecoration(
                              color: const Color(0XFF333F44),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      "Code:",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      codeController.clear();
                                    },
                                    child: const Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ElevatedButton(
                                      onPressed: _runCode,
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xFF48CF3C),
                                      ),
                                      child: const Text("Run"),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Expanded(
                                child: Container(
                                  height: screenHeight * 0.5,
                                  width: screenWidth * 0.85,
                                  color: Colors.black45,
                                  child: SingleChildScrollView(
                                      child: CodeField(
                                    controller: codeController,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                              color: const Color(0XFF333F44),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCodeVisible = false;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Icon(
                                        Icons.expand_less,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Result",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!isCodeVisible && selectedOption == 2)
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.55,
                    decoration: BoxDecoration(
                        color: const Color(0XFF333F44),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCodeVisible = true;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Icon(
                                  Icons.expand_more,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Result:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${response != null ? response['runs'].where((run) => run['passed'] == true).length : 0}/${widget.testCases.length} Test Cases Passed",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              widget.testCases.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTest = index + 1;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Test Case ${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (selectedTest == index + 1)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0XFFFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          height: 1.0,
                                          width: 70.0,
                                        )
                                      else
                                        Container(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Expected Outcome",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 100,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.testCases[selectedTest - 1],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Your Output",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        buildOutputWidget(),
                      ],
                    ),
                  ),
                if (selectedOption == 1)
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0XFF333F44),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.instruction ?? 'Instruction not available',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WideButton(
                    text: "Run",
                    screenHeight: screenHeight,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
