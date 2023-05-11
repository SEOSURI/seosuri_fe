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
      dataList = [
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
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final selectedData = dataList[index];
                return SizedBox(
                  height: 70,
                  child: ListTile(
                    title: Text(selectedData),
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
                  ),
                );
              },
            ),
          ),
          Container(
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

