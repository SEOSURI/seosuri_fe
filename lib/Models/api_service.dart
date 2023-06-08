import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:seosuri_fe/splashscreen.dart';

class ApiService {
  static const String baseUrl = "http://seosuri.site/api";

  // 문제 생성 api
  Future<List<dynamic>> sendData(String categoryTitle, String level) async {
    var url = Uri.parse('$baseUrl/problem/create');
    var body = jsonEncode({
      'categoryTitle': categoryTitle,
      'level': level,
    });

    var response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['result'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  // 문제 삭제 api
  Future<List<dynamic>> deleteSelectedData(int testPaperId, int probNum) async {
    var url = Uri.parse('$baseUrl/problem/delete');
    var body = jsonEncode({
      'testPaperId': testPaperId,
      'probNum': probNum,
    });

    var response = await http.delete(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['result'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  // 숫자 변경 api
  Future<List<dynamic>> changeNumber(int testPaperId, int probNum) async {
    var url = Uri.parse('$baseUrl/problem/change/number');
    var body = jsonEncode({
      'testPaperId': testPaperId,
      'probNum': probNum,
    });

    var response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print('Number changed successfully');
      return data['result'];
    } else {
      String errorMessage = response.body;
      throw Exception('Failed to change number: $errorMessage');
    }
  }

  // 문제 변경 api
  Future<List<dynamic>> changeProblem(int testPaperId, int probNum) async {
    var url = Uri.parse('$baseUrl/problem/change');
    var body = jsonEncode({
      'testPaperId': testPaperId,
      'probNum': probNum,
    });

    var response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print('Problem changed successfully');
      return data['result'];
    } else {
      String errorMessage = response.body;
      throw Exception('Failed to change problem: $errorMessage');
    }
  }

  // 이메일 발송 api
  static Future<void> sendEmail(String email, int testPaperId) async {
    var url = Uri.parse('$baseUrl/testpaper/email');
    var body = jsonEncode({
      'email': email,
      'testPaperId': testPaperId,
    });

    var response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      String errorMessage = response.body;
      throw Exception('Failed to send email: $errorMessage');
    }
  }

  static void _showTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timeout Error'),
          content: Text('시간이 초과되어 초기 화면으로 돌아갑니다.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}