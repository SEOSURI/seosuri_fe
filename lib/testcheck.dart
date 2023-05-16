import 'package:flutter/material.dart';
import 'package:seosuri_fe/emailscreen.dart';
import 'package:seosuri_fe/testcor.dart';

class TestCheckScreen extends StatefulWidget {
  @override
  _TestCheckScreenState createState() => _TestCheckScreenState();
}

class _TestCheckScreenState extends State<TestCheckScreen> {
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data from BE
  }

  void fetchData() {
    setState(() {
      // Simulated data from BE
      dataList = [ // 2차원 배열로 문제1,문제내용
        '문제 1',
        '문제 2',
        '문제 3',
        '문제 4',
        '문제 5',
        '문제 6',
        '문제 7',
        '문제 8',
        '문제 9',
        '문제 10',
      ];
    });
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
                final selectedData = dataList[index];
                final questionNumber = index + 1; // Adjust question number index (starting from 1)
                final difficulty = '난이도 데이터'; // Replace with actual difficulty data
                final questionContent = '문제 내용 데이터'; // Replace with actual question content data

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestCorrectionScreen(
                          selectedData: selectedData,
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
                          '문제 $questionNumber ( $difficulty )',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        Text(
                          questionContent,
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

