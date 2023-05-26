// // test
// _postRequest() async {
//   String url = 'http://seosuri.site/api/problem/create';
//
//   http.Response response = await http.post(
//     url,
//     headers: <String, String> { //기타 부가정보가 담겨져 있는 공간
//       'Content-Type': 'application/x-www-form-urlencoded',
//     },
//     body: <String, String> { //프론트에서 백으로 보내는 데이터
//       'user_id': 'user_id_value',
//       'user_pwd': 'user_pwd_value'
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/testcheck_provider.dart';
import 'testcor.dart';

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
    fetchData = Provider.of<TestCheckProvider>(context, listen: false)
        .fetchData(widget.categoryTitle, widget.level);
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
          } else if (snapshot.hasError) {
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
        },
      ),
    );
  }

  Widget buildContent(List<ProblemData> dataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '문제지 번호 : ${dataList[0].testPaperId}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      ],
    );
  }
}