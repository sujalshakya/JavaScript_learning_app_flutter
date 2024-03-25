import 'package:flutter/material.dart';
import 'package:javascript/constants/constants.dart';
import 'package:javascript/constants/text_style.dart';

class MyTargets extends StatelessWidget {
  const MyTargets({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          'My Targets',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        iconTheme: const IconThemeData(
          color: Color(0xFF644AFF),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Add",
              style: TextStyle(
                color: AppConstants.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/background/mytargets.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "YOU CAN DO IT",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Target(),
                    const Target(),
                    const Target(),
                    const Target(),
                    const Target()
                  ],
                ))),
      ),
    );
  }
}

class Target extends StatelessWidget {
  const Target({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Tomorrow",
                style: AppTextStyles.headingStyle,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                "Complete",
                style: TextStyle(
                  color: AppConstants.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "Complete lesson 1",
                style: TextStyle(color: Color(0XFF818181)),
              ),
              Spacer(),
              Text("6:00 pm", style: TextStyle(color: Color(0XFF818181)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  height: 32,
                  width: 4,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: Colors.grey,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "Complete quiz 1",
                style: TextStyle(color: Color(0XFF818181)),
              ),
              Spacer(),
              Text("6:00 pm", style: TextStyle(color: Color(0XFF818181)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  height: 32,
                  width: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
