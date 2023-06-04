import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://seosuri.site/api/problem";

  Future<List<dynamic>> sendData(String categoryTitle, String level) async {
    var url = Uri.parse('$baseUrl/create');
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

  Future<List<dynamic>> deleteSelectedData(int testPaperId, int probNum) async {
    var url = Uri.parse('$baseUrl/delete');
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
}
