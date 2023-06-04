import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://seosuri.site/api";

  // 문제 생성 api
  Future<List<dynamic>> sendData(String categoryTitle, String level) async {
    var url = Uri.parse('$baseUrl/problem/create');
    var body = jsonEncode({
      'categoryTitle': categoryTitle,
      'level': level,
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      //print(data['result']);
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

    var response = await http.delete(url, body: body, headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      // print(data['result']);
      return data['result'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  // 숫자 변경 api


  // 문제 변경 api


  // 이메일 발송 api
  static Future<void> sendEmail(String email, int testPaperId) async {
    var url = Uri.parse('$baseUrl/testpaper/email');

    var queryParameters = {
      'email': email,
      'testPaperId': testPaperId,
    };
    var uri = Uri(
      scheme: url.scheme,
      host: url.host,
      port: url.port,
      path: url.path,
      queryParameters: queryParameters,
    );

    print("GET 요청, email : $email, testPaperId : $testPaperId");

    var response = await http.get(
      uri,
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

}
