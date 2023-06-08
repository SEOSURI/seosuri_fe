import 'package:flutter/material.dart';
import 'package:seosuri_fe/Models/api_service.dart';
import 'package:seosuri_fe/splashscreen.dart';

class EmailScreen extends StatefulWidget {
  final int testPaperId;

  EmailScreen({Key? key, required this.testPaperId}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  bool _isSendingEmail = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(
      String labelText, String hintText, String? errorText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      errorStyle: TextStyle(color: Colors.red),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSendingEmail = true;
      });

      final recipient = _emailController.text.trim();
      int testPaperId = widget.testPaperId;

      print('emailscreen.dart화면에서 입력받은 값');
      print('Recipient Email : $recipient');
      print('TestPaperId : $testPaperId');

      try {
        await ApiService.sendEmail(recipient, testPaperId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일이 성공적으로 발송되었습니다.\n초기화면으로 돌아가기 버튼을 눌러주세요.'),
            duration: Duration(seconds: 3),
          ),
        );
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일 발송 중 오류가 발생하였습니다. \n잠시 후 다시 시도해주세요.'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      setState(() {
        _isSendingEmail = false;
      });
    }
  }
  void _navigateToStart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            "이메일 발송",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:
                _buildInputDecoration('이메일', '이메일을 입력하세요', null),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이메일을 입력하세요';
                  } else if (!RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return '올바른 이메일 형식을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSendingEmail ? null : _sendEmail,
                child: _isSendingEmail
                    ? CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text('전송'),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: !_isSendingEmail, // Show only after email is sent successfully
                child: ElevatedButton(
                  onPressed: _navigateToStart, // Navigate to splashscreen
                  child: Text('초기 화면으로 돌아가기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}