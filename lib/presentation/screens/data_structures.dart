import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataStructures extends StatefulWidget {
  final int index;

  const DataStructures({super.key, required this.index});

  @override
  State<DataStructures> createState() => _DataStructuresState();
}

class _DataStructuresState extends State<DataStructures> {
  List<Map<String, dynamic>> dataStructure = [];
  @override
  void initState() {
    super.initState();
    fetchLessonData();
  }

  Future<void> fetchLessonData() async {
    final response =
        await http.get(Uri.parse('https://api.codynn.com/api/datastructures'));

    if (response.statusCode == 200) {
      final List<dynamic> structureData = json.decode(response.body);
      setState(() {
        dataStructure =
            structureData.isNotEmpty ? [structureData[widget.index]] : [];
      });
    } else {
      throw Exception('Failed to load lesson data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
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
          "Data Structure",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: dataStructure.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataStructure[0]['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dataStructure[0]['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      if (dataStructure[0]['content'] != null &&
                          dataStructure[0]['content']['blocks'] != null &&
                          dataStructure[0]['content']['blocks'].isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dataStructure[0]['content']['blocks']
                              .map<Widget>((block) {
                            switch (block['type']) {
                              case 'heading':
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    block['data']['text'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              case 'paragraph':
                                return Text(
                                  block['data']['text'],
                                  style: const TextStyle(fontSize: 16),
                                );
                              case 'code':
                                return Text(
                                  block['data']['code'],
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Courier'),
                                );
                              default:
                                return const SizedBox();
                            }
                          }).toList(),
                        )
                      else
                        const Text(
                          "",
                          style: TextStyle(fontSize: 16),
                        ),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
