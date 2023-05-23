import 'package:seosuri_fe/testcor.dart';
import 'emailscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestCheckScreen extends StatefulWidget {
  final String categoryTitle;
  final String level;

  TestCheckScreen({
    required this.categoryTitle,
    required this.level,
  });

  @override
  _TestCheckScreenState createState() => _TestCheckScreenState();
}

class _TestCheckScreenState extends State<TestCheckScreen> {
  var dataList;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data from the API
  }

  void fetchData() async {
    var url = Uri.parse('http://seosuri.site/api/problem/create');
    var body = jsonEncode({
      'categoryTitle': widget.categoryTitle,
      'level': widget.level,
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      dataList = data;
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 목록'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '수정하고 싶다면 해당 문제를 누르세요.',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final problemData = dataList[index];
                final testPaperId = problemData['testPaperId'];
                final num = problemData['num'];
                final level = problemData['level'];
                final content = problemData['content'];
                final explanation = problemData['explanation'];
                final answer = problemData['answer'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestCorrectionScreen(
                          selectedData: content,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '문제 $num ( $level )',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        Text(
                          content,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 16),
                        Divider(), // Add a divider between questions
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailScreen(),
                  ),
                );
              },
              child: Text('완료하기'),
            ),
          ),
        ],
      ),
    );
  }
}