import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';

class QuestionDetails extends StatefulWidget {
  final int index;
  final String? question;
  final String? explanation;
  final String? flowchart;
  final String? code;
  final String? algorithm;
  final String? id;

  QuestionDetails(
      {Key? key,
      required this.index,
      required this.question,
      required this.algorithm,
      required this.explanation,
      required this.flowchart,
      required this.code,
      required this.id})
      : super(key: key);

  @override
  State<QuestionDetails> createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails> {
  dynamic response;
  bool isLoading = false;
  List<String> favoriteIds = [];
  late bool isInFavorite = false;

  @override
  void initState() {
    super.initState();

    getFavorite().then((_) {
      setState(() {
        isInFavorite = favoriteIds.contains(widget.id);
      });
    });
  }

  getFavorite() async {
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
        print('Favorite question IDs: $favoriteIds');
      } else {
        print('Failed to fetch favorite questions: ${httpResponse.body}');
      }
    });
  }

  void addFavorite() async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    http.Response httpResponse = await http.post(
      Uri.parse('https://api.codynn.com/api/favourites'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{"question": widget.id}),
    );

    setState(() {
      if (httpResponse.statusCode == 201) {
        isInFavorite = true;
        print(httpResponse.body);
        print(isInFavorite);
        response = jsonDecode(httpResponse.body);
      } else {
        response = null;
        print(httpResponse.body);
      }
    });
  }

  void deleteFavorite(String? questionId) async {
    var box = await Hive.openBox('SETTINGS');
    final String? token = box.get('token');

    http.Response httpResponse =
        await http.delete(Uri.parse('https://api.codynn.com/api/favourites'),
            headers: <String, String>{
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
              <String, dynamic>{"question": widget.id},
            ));

    setState(() {
      if (httpResponse.statusCode == 200) {
        isInFavorite = false;
        print('Question removed from favorites');
        const SnackBar(content: Text("deleted"));
      } else {
        print(response);
      }
    });
  }

  int selectedOption = 1;
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
          "Question",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (isInFavorite) {
                deleteFavorite(widget.id);
              } else {
                addFavorite();
              }
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            icon: Icon(
                isInFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: isInFavorite ? Colors.red : Colors.black),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          '${widget.index + 1}',
                          style:
                              const TextStyle(color: AppConstants.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.question ?? '',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
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
                          'Code',
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Algorithm',
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
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 3;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Flowchart',
                          style: TextStyle(
                            color: selectedOption == 3
                                ? const Color(0XFF644AFF)
                                : const Color(0XFFA3A3A3),
                            fontSize: 16,
                          ),
                        ),
                        selectedOption == 3
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 4;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Explanation',
                          style: TextStyle(
                            color: selectedOption == 4
                                ? const Color(0XFF644AFF)
                                : const Color(0XFFA3A3A3),
                            fontSize: 16,
                          ),
                        ),
                        selectedOption == 4
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
                ],
              ),
              const SizedBox(height: 20),
              if (selectedOption == 1)
                SizedBox(
                  height: screenHeight * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.7,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.code ?? 'Code not available',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Container(
                        //   width: screenWidth,
                        //   height: screenHeight * 0.5,
                        //   decoration: BoxDecoration(
                        //       color: const Color(0XFF333F44),
                        //       borderRadius: BorderRadius.circular(12)),
                        //   child: const Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Padding(
                        //             padding: EdgeInsets.symmetric(
                        //                 horizontal: 16, vertical: 8),
                        //             child: Text(
                        //               "Output:",
                        //               style: TextStyle(
                        //                   color: Colors.white, fontSize: 16),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Divider(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              if (selectedOption == 2)
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.7,
                  decoration: BoxDecoration(
                      color: const Color(0XFF333F44),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.algorithm ?? 'Algorithm not available',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              if (selectedOption == 3)
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: widget.flowchart != null
                        ? Image.network(
                            widget.flowchart!,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const CircularProgressIndicator();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Text('Error loading image');
                            },
                          )
                        : const Text(
                            'Flowchart not available',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              if (selectedOption == 4)
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.7,
                  decoration: BoxDecoration(
                      color: const Color(0XFF333F44),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.explanation ?? 'Explanation not available',
                      style: const TextStyle(color: Colors.white),
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
