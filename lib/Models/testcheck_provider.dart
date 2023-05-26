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
}

class TestCheckProvider extends ChangeNotifier {
  List<ProblemData> dataList = [];
  final ApiService _apiService = ApiService();

  Future<void> fetchData(String categoryTitle, String level) async {
    List<dynamic> result = await _apiService.sendData(categoryTitle, level);
    dataList = result
        .map((data) => ProblemData(
      testPaperId: data['testPaperId'],
      num: data['num'],
      level: data['level'],
      content: data['content'],
    ))
        .toList();
    notifyListeners();
  }
}

