import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/testcheck_provider.dart';
import 'testcor.dart';
import 'emailscreen.dart';
import 'Models/email_provider.dart';
import 'Models/api_service.dart';

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
  late Future<void> fetchData;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData = fetchDataAndUpdate();
    });
  }

  // Future<void> fetchDataAndUpdate() async {
  //   try {
  //     TestCheckProvider provider = Provider.of<TestCheckProvider>(context, listen: false);
  //     List<ProblemData> result = await provider.sendData(widget.categoryTitle, widget.level);
  //     provider.dataList = result;
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  Future<void> fetchDataAndUpdate() async {
    try {
      TestCheckProvider provider = Provider.of<TestCheckProvider>(context, listen: false);
      await provider.fetchData(widget.categoryTitle, widget.level);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 목록'),
      ),
      body: FutureBuilder<void>(
        future: fetchData,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) { // 수정된 부분
              return Center(
                child: Text('오류 발생'),
              );
            } else {
              return Consumer<TestCheckProvider>(
                builder: (context, provider, _) {
                  return buildContent(provider.dataList);
                },
              );
            }
          }
        },
      ),
    );
  }

  // Widget buildContent(List<ProblemData> dataList) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: EdgeInsets.all(16),
  //         child: Text(
  //           '문제지 번호 : ${dataList[0].testPaperId}',
  //           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: dataList.length,
  //           itemBuilder: (context, index) {
  //             var problemData = dataList[index];
  //
  //             return GestureDetector(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => TestCorrectionScreen(
  //                       selectedData: problemData.content,
  //                       categoryTitle: widget.categoryTitle,
  //                       level: widget.level,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.all(16),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       '문제 ${problemData.num} (${problemData.level})',
  //                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                     ),
  //                     SizedBox(height: 7),
  //                     Text(
  //                       problemData.content,
  //                       style: TextStyle(fontSize: 13),
  //                     ),
  //                     SizedBox(height: 16),
  //                     Divider(),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       Align(
  //         alignment: Alignment.center,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 16.0),
  //           child: ElevatedButton(
  //             onPressed: () {
  //               navigateToEmailScreen(context);
  //             },
  //             child: Text('완성된 문제지를 이메일로 전송하기'),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildContent(List<ProblemData> dataList) {
    if (dataList.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '문제지 번호 : ${dataList[0].testPaperId}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              var problemData = dataList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestCorrectionScreen(
                        selectedData: problemData.content,
                        categoryTitle: widget.categoryTitle,
                        level: widget.level,
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
                        '문제 ${problemData.num} (${problemData.level})',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 7),
                      Text(
                        problemData.content,
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                navigateToEmailScreen(context);
              },
              child: Text('완성된 문제지를 이메일로 전송하기'),
            ),
          ),
        ),
      ],
    );
  }


  void navigateToEmailScreen(BuildContext context) {
    Provider.of<EmailProvider>(context, listen: false).sendEmail('Email content');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(),
      ),
    );
  }
}