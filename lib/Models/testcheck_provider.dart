import 'package:flutter/material.dart';
import 'package:seosuri_fe/Models/api_service.dart';

//문제 데이터를 나타내는 클래스 - TestCheckProvider 내에서 문제 데이터 저장하고 관리
class ProblemData {
  final int testPaperId;
  final int num;
  String? level;
  String? content;

  ProblemData({
    required this.testPaperId,
    required this.num,
    required this.level,
    required this.content,
  });

  //api에서 받은 값 ProblemData객체로 변환하는 팩토리 메서드
  factory ProblemData.fromJson(Map<String, dynamic> json) {
    return ProblemData(
      testPaperId: json['testPaperId'],
      num: json['num'],
      level: json['level'],
      content: json['content'],
    );
  }
  // Method to create a copy of ProblemData with updated values
  ProblemData copyWith({
    int? testPaperId,
    int? num,
    String? level,
    String? content,
  }) {
    return ProblemData(
      testPaperId: testPaperId ?? this.testPaperId,
      num: num ?? this.num,
      level: level ?? this.level,
      content: content ?? this.content,
    );
  }
}

class TestCheckProvider extends ChangeNotifier {
  List<ProblemData> dataList = [];
  ApiService _apiService = ApiService();

  //api에서 받은 데이터 result값을 dataList에 리스트별로 저장
  Future<void> fetchData(String categoryTitle, String level) async {
    List<dynamic> result = await _apiService.sendData(categoryTitle, level);
    dataList = result
        .map((data) => ProblemData.fromJson(data))
        .toList();
    notifyListeners();
  }

  //api에서 받은 데이터 result값을 다시 dataList에 저장
  Future<void> deletedData(int testPaperId, int probNum) async {
    // dataList의 모든 값을 삭제
    dataList.clear();
    List<dynamic> result = await _apiService.deleteSelectedData(
        testPaperId, probNum);
    // 결과를 변수에 할당
    List<ProblemData> deletedDataList = result.map((data) =>
        ProblemData.fromJson(data)).toList();
    // 업데이트된 데이터 리스트를 dataList에 추가
    dataList.addAll(deletedDataList);
    notifyListeners();
  }

  // 숫자 변경 provider
  Future<void> chg_Number(int testPaperId, int probNum) async {
    // API를 통해 숫자 변경 또는 문제 변경을 요청
    try {
      // changeNumber 메서드를 호출하여 결과값을 받아옴
      await _apiService.changeNumber(testPaperId, probNum);

      // API 요청이 성공한 경우 해당 인덱스의 데이터를 업데이트
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].num == probNum) {
          dataList[i] = dataList[i].copyWith(testPaperId: testPaperId);
          break;
        }
      }

      notifyListeners();
    } catch (e) {
      // 요청이 실패한 경우에 대한 예외 처리
      print('Failed to change data: $e');
      rethrow;
    }
  }


  // 문제 변경 provider
  Future<void> chg_Problem(int testPaperId, int probNum) async {
    // API를 통해 문제 변경을 요청
    try {
      // changeProblem 메서드를 호출하여 결과값을 받아옴
      await _apiService.changeProblem(testPaperId, probNum);

      // API 요청이 성공한 경우 해당 인덱스의 데이터를 업데이트
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].num == probNum) {
          dataList[i] = dataList[i].copyWith(testPaperId: testPaperId);
          break;
        }
      }

      notifyListeners();
    } catch (e) {
      // 요청이 실패한 경우에 대한 예외 처리
      print('Failed to change problem: $e');
      rethrow;
    }
  }
}