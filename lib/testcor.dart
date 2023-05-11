import 'package:flutter/material.dart';

class TestCorrectionScreen extends StatelessWidget {
  final String selectedData;

  TestCorrectionScreen({required this.selectedData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수정하고 싶은 데이터:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              selectedData,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement '삭제' button logic
              },
              child: Text('삭제'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement '숫자 변경' button logic
              },
              child: Text('숫자 변경'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement '문제 변경' button logic
              },
              child: Text('문제 변경'),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('문제목록으로 돌아가기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
