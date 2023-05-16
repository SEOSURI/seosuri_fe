import 'package:flutter/material.dart';
import 'dart:io';
import 'testcheck.dart';

class CheckScreen extends StatefulWidget {
  final List<String> data;
  final File? imageFile;

  CheckScreen({required this.data, this.imageFile});

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  int selectedSentenceIndex = -1;
  bool showCompleteButton = false;

  List<String> getRandomTextList() {
    return ['어떤 수는 48에서 3을 뺀 수를 5로 나눈 몫에 2를 더한 수와 같습니다. 어떤 수를 구하시오.',
      '태형의 나이는 23살이며 지민은 태형보다 3살 적습니다. 지민의 나이는 몇 살일까요?',
      '길이가 38cm인 종이테이프를 2등분 하여 10cm가 겹치게 이어 붙였을 때 종이테이프의 전체 길이는 몇 cm입니까?',
      '한 변의 길이가 12cm인 정사각형과 가로가 8cm, 세로가 14cm인 직사각형이 있습니다. 두 도형의 둘레의 차를 구하시오.'
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<String> textList = getRandomTextList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '선택된 문제 확인',
          style: TextStyle(fontSize: 19,
            fontFamily: 'nanum-square',
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '당신이 선택한 문제',
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
          Text('유형 확인하기 (정확도 순에 따라 나열되어 있습니다.)',
          style: TextStyle(
            fontSize: 12
          )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.data.length, (index) {
                final item = textList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSentenceIndex = index;
                      showCompleteButton = true;
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
                    child: Text('상',
                    style: TextStyle(
                      fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement '상' button logic
                    },
                  ),
                  ElevatedButton(
                    child: Text('중',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement '중' button logic
                    },
                  ),
                  ElevatedButton(
                    child: Text('하',
                      style: TextStyle(
                        fontFamily: 'nanum-square',
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement '하' button logic
                    },
                  ),
                ],
              ),
            ),
          if (showCompleteButton)
            Container(
              child: ElevatedButton(
                child: Text('해당 유형과 난이도에 적합한 문제지 생성하기',
                style: TextStyle(
                  fontFamily: 'nanum-square'
                ),
                ),
                onPressed: () {
                  // TODO: Send selected image to BE
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => TestCheckScreen(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}