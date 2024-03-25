import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';

import 'package:javascript/presentation/widgets/coin.dart';


class Challenges extends StatelessWidget {
  const Challenges({super.key});

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
          "Games",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: AssetImage("assets/background/challenges.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.5),
                                  borderRadius: BorderRadius.circular(32)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Coin(text: "CP"),
                                  Text(
                                    "+50",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.2,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Challenges",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.42,
                      height: screenHeight * 0.040,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppConstants.primaryColor)),
                      child: DropdownButton<String>(
                        value: 'Difficulty',
                        onChanged: (String? newValue) {},
                        elevation: 16,
                        isExpanded: true,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(12),
                        style:
                            const TextStyle(color: AppConstants.primaryColor),
                        dropdownColor: Colors.white,
                        items: <String>['Difficulty', 'Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Container(
                      width: screenWidth * 0.42,
                      height: screenHeight * 0.040,
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppConstants.primaryColor)),
                      child: DropdownButton<String>(
                        value: 'Category',
                        onChanged: (String? newValue) {},
                        elevation: 16,
                        underline: Container(),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12),
                        style:
                            const TextStyle(color: AppConstants.primaryColor),
                        dropdownColor: Colors.white,
                        items: <String>['Category', 'Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: const Color(0XFF333F44),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Question 1",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "question",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Easy",
                              style: TextStyle(color: Color(0XFF48CF3C)),
                            ),
                            SizedBox(
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF644AFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                child: const Text("Start"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: const Color(0XFF333F44),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Question 1",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "question",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Hard",
                              style: TextStyle(color: Color(0XFFFF4B57)),
                            ),
                            SizedBox(
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF644AFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                child: const Text("Start"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: const Color(0XFF333F44),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Question 1",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "question",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Easy",
                              style: TextStyle(color: Color(0XFF48CF3C)),
                            ),
                            SizedBox(
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF644AFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                child: const Text("Start"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
