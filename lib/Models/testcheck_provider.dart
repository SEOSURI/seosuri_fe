import 'package:flutter/material.dart';
import 'package:seosuri_fe/Models/api_service.dart';

class ProblemData {
  final int testPaperId;
  final int num;
  final String level;
  final String content;

  ProblemData({
    required this.testPaperId,
    required this.num,
    required this.level,
    required this.content,
  });

  factory ProblemData.fromJson(Map<String, dynamic> json) {
    return ProblemData(
      testPaperId: json['testPaperId'],
      num: json['num'],
      level: json['level'],
      content: json['content'],
    );
  }
}

class TestCheckProvider extends ChangeNotifier {
  List<ProblemData> dataList = [];
  ApiService _apiService = ApiService();

  Future<void> fetchData(String categoryTitle, String level) async {
    List<dynamic> result = await _apiService.sendData(categoryTitle, level);
    dataList = result
        .map((data) => ProblemData.fromJson(data))
        .toList();
    notifyListeners();
  }

  Future<void> deletedData(int testPaperId, int probNum) async {
    // dataList의 모든 값을 삭제
    dataList.clear();

    List<dynamic> result = await _apiService.deleteSelectedData(testPaperId, probNum);
    // 결과를 변수에 할당
    List<ProblemData> deletedDataList = result.map((data) => ProblemData.fromJson(data)).toList();

    // 업데이트된 데이터 리스트를 dataList에 추가
    dataList.addAll(deletedDataList);

    notifyListeners();
  }
}