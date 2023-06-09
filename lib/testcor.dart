import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seosuri_fe/Models/testcheck_provider.dart';
import 'Models/api_service.dart';

class TestCorrectionScreen extends StatefulWidget {
  final String selectedData;
  final String categoryTitle;
  final String level;
  final int testPaperId;
  final int probNum;

  TestCorrectionScreen({
    required this.selectedData,
    required this.categoryTitle,
    required this.level,
    required this.testPaperId,
    required this.probNum,
  });

  @override
  _TestCorrectionScreenState createState() => _TestCorrectionScreenState();
}

class _TestCorrectionScreenState extends State<TestCorrectionScreen> {
  late int testPaperId;
  late int probNum;
  final ApiService apiService = ApiService();
  bool isDataDeleted = false;
  bool hasError = false;

  List<ProblemData> dataList = [];

  @override
  void initState() {
    super.initState();
    testPaperId = widget.testPaperId;
    probNum = widget.probNum;
    print('testcheck.dart에서 testcor.dart으로 넘어온 값');
    print('testPaperId: $testPaperId');
    print('probNum: $probNum');
    fetchData();
  }

  Future<List<ProblemData>> fetchData() async {
    try {
      List<dynamic> data = await apiService.sendData(widget.categoryTitle, widget.level);
      List<ProblemData> updatedDataList = data.map((dynamic item) {
        return ProblemData.fromJson(item); // Replace ProblemData.fromJson with your own conversion logic
      }).toList();
      setState(() {
        dataList = updatedDataList;
      });
      return updatedDataList;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<void> deleteData(int testPaperId, int probNum) async {
    try {
      await Provider.of<TestCheckProvider>(context, listen: false)
          .deletedData(testPaperId, probNum);
      await fetchData();
      setState(() {
        isDataDeleted = true;
      });
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  void _changeNumber() async {
    TestCheckProvider testCheckProvider = Provider.of<TestCheckProvider>(context, listen: false);
    try {
      await testCheckProvider.chg_Number(testPaperId, probNum);

      // Handle the success or display a success message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('숫자 변경 완료'),
            content: Text('숫자 변경이 성공적으로 완료되었습니다.'),
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
    } catch (e) {
      // Handle the error or display an error message
      print('Error changing number: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류 발생'),
            content: Text('숫자 변경 중 오류가 발생했습니다.'),
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

  void _changeProblem() async {
    TestCheckProvider testCheckProvider = Provider.of<TestCheckProvider>(context, listen: false);
    try {
      await testCheckProvider.chg_Problem(testPaperId, probNum);

      // Handle the success or display a success message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('문제 변경 완료'),
            content: Text('문제 변경이 성공적으로 완료되었습니다.'),
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
    } catch (e) {
      // Handle the error or display an error message
      print('Error changing number: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류 발생'),
            content: Text('문제 변경 중 오류가 발생했습니다.'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('선택한 문제 수정',textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '수정하고 싶은 문제 :',
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
              if (hasError)
                AlertDialog(
                  title: Text(
                    '오류 발생',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        setState(() {
                          hasError = false;
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 문제 삭제
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('문제 삭제 확인'),
                            content: Text(
                                '해당 문제를 정말 삭제하시겠습니까?\n 삭제를 누른 후 목록화면으로 돌아가기 버튼을 눌러주세요.'
                                ''),
                            actions: [
                              TextButton(
                                child: Text('취소'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('삭제'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteData(testPaperId, probNum);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('문제 삭제'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10,),
                  // 숫자 변경
                  ElevatedButton(
                    onPressed: _changeNumber,
                    child: Text('숫자 변경'),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: _changeProblem,
                    child: Text('문제 변경'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('문제목록으로 돌아가기'),
                ),
              ),
              if (isDataDeleted)
                AlertDialog(
                  title: Text(
                    '데이터 삭제 완료',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        setState(() {
                          isDataDeleted = false;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
