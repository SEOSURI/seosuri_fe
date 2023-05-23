import 'package:flutter/material.dart';

class TestCorrectionScreen extends StatelessWidget {
  final String selectedData;

  TestCorrectionScreen({required this.selectedData});

  void deleteSelectedData() {
    // Implement the logic to delete the selected data
    // You can make an API request or update the data locally
  }

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
            SizedBox(height: 9),
            Text(
              selectedData,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Confirmation'),
                          content: Text('Are you sure you want to delete?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                deleteSelectedData(); // Delete the selected data

                                Navigator.pop(context, true); // Close the dialog and pass true as the result
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      fontFamily: 'nanum-square',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement '숫자 변경' button logic
                  },
                  child: Text(
                    '숫자 변경',
                    style: TextStyle(
                      fontFamily: 'nanum-square',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement '문제 변경' button logic
                  },
                  child: Text(
                    '문제 변경',
                    style: TextStyle(
                      fontFamily: 'nanum-square',
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Close the screen and pass false as the result
                },
                child: Text(
                  '문제목록으로 돌아가기',
                  style: TextStyle(
                    fontFamily: 'Nanum-square',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}