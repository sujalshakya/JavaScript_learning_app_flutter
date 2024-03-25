import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';


class BuyCoins extends StatelessWidget {
  const BuyCoins({super.key});

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
          "Buy Code Coins",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: SizedBox(
              width: screenWidth * 0.9,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/background/buycoins.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                "Buy Code Coins",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Container(
                              height: screenHeight * 0.23,
                              width: screenWidth * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0XFFF1F1F1)),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Starter Pack",
                                      style: AppTextStyles.headingStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      "assets/icons/codecoins.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                  const Text("100 Code Coins"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Rs. 300",
                                          style: TextStyle(
                                              color: AppConstants.primaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: -10,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Banner(
                                  message: ' Popular',
                                  color: Colors.red,
                                  location: BannerLocation.topStart,
                                  child: SizedBox(
                                    width: 250,
                                    height: 150,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.23,
                            width: screenWidth * 0.40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0XFFF1F1F1)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Competent Pack",
                                    style: AppTextStyles.headingStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/icons/2coins.png",
                                    height: 80,
                                    width: 90,
                                  ),
                                ),
                                const Text("200 Code Coins"),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Rs. 600",
                                        style: TextStyle(
                                            color: AppConstants.primaryColor),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF644AFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF644AFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.23,
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0XFFF1F1F1)),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Intermediate Pack",
                                    style: AppTextStyles.headingStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/icons/3coins.png",
                                    height: 80,
                                    width: 120,
                                  ),
                                ),
                                const Text("300 Code Coins"),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Rs. 1200",
                                        style: TextStyle(
                                            color: AppConstants.primaryColor),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Container(
                              height: screenHeight * 0.23,
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0XFFF1F1F1)),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Starter Pack",
                                      style: AppTextStyles.headingStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/icons/4coins.png",
                                      height: 80,
                                      width: 180,
                                    ),
                                  ),
                                  const Text("400 Code Coins"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Rs. 300",
                                          style: TextStyle(
                                              color: AppConstants.primaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: -10,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Banner(
                                  message: ' Best Deal',
                                  color: Colors.red,
                                  location: BannerLocation.topStart,
                                  child: SizedBox(
                                    width: 250,
                                    height: 150,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF644AFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF644AFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]))),
    );
  }
}
