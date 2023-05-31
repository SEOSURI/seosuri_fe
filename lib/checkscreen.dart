import 'package:flutter/material.dart';
import 'dart:io';
import 'testcheck.dart';
import 'Models/check_provider.dart';

class CheckScreen extends StatefulWidget {
  final List<ProblemData> data;
  final File? imageFile;

  CheckScreen({required this.data, this.imageFile});

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  int selectedSentenceIndex = -1;
  bool showCompleteButton = false;
  String? selectedCategoryTitle;
  String? selectedLevel;
  TestCheckProvider provider = TestCheckProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '선택된 문제 확인',
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'nanum-square',
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '선택한 문제',
              style: TextStyle(fontSize: 14),
            ),
          ),
          if (widget.imageFile != null)
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[230],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.file(widget.imageFile!, fit: BoxFit.cover),
            ),
          Text(
            '유형 확인하기',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.data.length, (index) {
                final item = widget.data[index].example;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSentenceIndex = index;
                      showCompleteButton = true;
                      selectedCategoryTitle = null; // Reset the selected category title
                      selectedLevel = null; // Reset the selected level
                    });
                  },
                  child: Container(
                    width: 220,
                    height: 130,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedSentenceIndex == index
                          ? Colors.grey[300]
                          : Colors.grey[230],
                      borderRadius: BorderRadius.circular(10),
                      border: selectedSentenceIndex == index
                          ? Border.all(
                        color: Colors.black45,
                        width: 2.0,
                      )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedSentenceIndex == index
                              ? Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (selectedSentenceIndex != -1)
            Container(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      '상',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategoryTitle = widget.data[selectedSentenceIndex].categoryTitle;
                        selectedLevel = '상';
                      });
                      sendData('상');
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      '중',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategoryTitle = widget.data[selectedSentenceIndex].categoryTitle;
                        selectedLevel = '중';
                      });
                      sendData('중');
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      '하',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategoryTitle = widget.data[selectedSentenceIndex].categoryTitle;
                        selectedLevel = '하';
                      });
                      sendData('하');
                    },
                  ),
                ],
              ),
            ),
          if (showCompleteButton && selectedCategoryTitle != null && selectedLevel != null)
            Container(
              child: Column(
                children: [
                  Text(
                    '선택된 유형: ${widget.data[selectedSentenceIndex].categoryTitle}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '선택된 난이도: $selectedLevel',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      '해당 유형과 난이도에 적합한 문제지 생성하기',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestCheckScreen(
                            categoryTitle: widget.data[selectedSentenceIndex].categoryTitle,
                            level: selectedLevel!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void sendData(String level) async {
    if (selectedSentenceIndex != -1) {
      final selectedSentence = widget.data[selectedSentenceIndex].example;
      final parts = selectedSentence.split(' ');
      if (parts.length > 1) {
        selectedCategoryTitle = parts[0];
        // level is passed as a parameter
      }
    }

    if (selectedCategoryTitle != null && level != null) {
      final questions = await provider.fetchData(selectedCategoryTitle!, level);
      // Process the fetched questions as needed
      print(questions);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('유형과 난이도를 다시 선택해주세요.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}