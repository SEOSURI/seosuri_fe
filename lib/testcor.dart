import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/api_service.dart';
import 'Models/testcheck_provider.dart';

class TestCorrectionScreen extends StatefulWidget {
  final String selectedData;
  final String categoryTitle;
  final String level;

  TestCorrectionScreen({
    required this.selectedData,
    required this.categoryTitle,
    required this.level,
  });

  @override
  _TestCorrectionScreenState createState() => _TestCorrectionScreenState();
}

class _TestCorrectionScreenState extends State<TestCorrectionScreen> {
  late Future<bool> deleteDataFuture;
  late int testPaperId;
  late int probNum;
  final apiService = ApiService();
  bool isDataDeleted = false;
  bool hasError = false; // 추가된 부분

  @override
  void initState() {
    super.initState();
    deleteDataFuture = deleteData();
  }

  Future<bool> deleteData() async {
    try {
      testPaperId = int.parse(widget.selectedData.trim().split(',')[0]);
      probNum = int.parse(widget.selectedData.trim().split(',')[1]);

      await apiService.deleteSelectedData(testPaperId, probNum);

      await fetchDataAndUpdate();
      return true;
    } catch (e) {
      print('Error deleting data: $e');
      return false;
    }
  }

  Future<void> fetchDataAndUpdate() async {
    try {
      await Provider.of<TestCheckProvider>(context, listen: false)
          .fetchData(widget.categoryTitle, widget.level);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 수정'),
      ),
      body: FutureBuilder<bool>(
        future: deleteDataFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) { // 수정된 부분
              hasError = true;
            }
            if (snapshot.data == true) {
              isDataDeleted = true;
            }
            return Padding(
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
                    widget.selectedData,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 120),
                  //여기서부터 안됨
                  if (isDataDeleted)
                    Text(
                      '데이터가 삭제되었습니다.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  if (hasError) // 수정된 부분
                    Text(
                      '오류 발생',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('선택된 문제 삭제 확인'),
                                content: Text('선택된 문제를 삭제하겠습니까?'),
                                actions: [
                                  TextButton(
                                    child: Text('취소'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('삭제'),
                                    onPressed: () async {
                                      await deleteData();
                                        fetchDataAndUpdate();
                                        Navigator.popAndPushNamed(context,'/testcheck');
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
                        Navigator.pop(context, false);
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
            );
          }
        },
      ),
    );
  }
}