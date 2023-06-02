import 'package:flutter/material.dart';

// check화면에서, 선택된 유형과 난이도를 백에서 보내는 provider

class TestCheckProvider extends ChangeNotifier {
  Future<List<String>> fetchData(String categoryTitle, String level) async {
    // TODO: Implement API logic to send data and fetch 10 questions
    // You can return a list of ProblemData objects representing the fetched questions

    // Mock implementation with sample data
    await Future.delayed(Duration(seconds: 2)); // Simulating API delay

    // Example data using getRandomTextList()
    final List<scProblemData> problemDataList = getRandomTextList();

    return [];
  }
}
class scProblemData {
  final String categoryTitle;
  final String example;

  scProblemData({
    required this.categoryTitle,
    required this.example,
  });
}

List<scProblemData> getRandomTextList() {
  return [
    scProblemData(
      categoryTitle: '어떤수',
      example: '어떤 수는 48에서 3을 뺀 수를 5로 나눈 몫에 2를 더한 수와 같습니다. 어떤 수를 구하시오.',
    ),
    scProblemData(
      categoryTitle: '나이_구하기',
      example: '태형의 나이는 23살이며 지민은 태형보다 3살 적습니다. 지민의 나이는 몇 살일까요?',
    ),
    scProblemData(
      categoryTitle: '이은_색테이프',
      example: '길이가 38cm인 종이테이프를 2등분 하여 10cm가 겹치게 이어 붙였을 때 종이테이프의 전체 길이는 몇 cm입니까?',
    ),
    scProblemData(
      categoryTitle: '도형_혼합계산_응용',
      example: '한 변의 길이가 12cm인 정사각형과 가로가 8cm, 세로가 14cm인 직사각형이 있습니다. 두 도형의 둘레의 차를 구하시오.',
    ),
  ];
}
