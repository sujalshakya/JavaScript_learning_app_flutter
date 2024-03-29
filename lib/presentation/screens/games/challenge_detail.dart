import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:javascript/presentation/widgets/widebutton.dart';

class ChallengeDetails extends StatefulWidget {
  final int index;
  final String? question;
  final String? instruction;
  const ChallengeDetails({
    Key? key,
    required this.index,
    required this.question,
    required this.instruction,
  }) : super(key: key);

  @override
  State<ChallengeDetails> createState() => ChallengeDetailsState();
}

class ChallengeDetailsState extends State<ChallengeDetails> {
  int selectedOption = 1;
  bool isCodeVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
        child: Container(
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.index}',
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
                                'instruction',
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
                                  const Text(
                                    "Clear",
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red,
                                    ),
                                  ),
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
                              const SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                                      "Output:",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!isCodeVisible)
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
                                "Output:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Clear",
                                style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
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
                    text: "Submit",
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