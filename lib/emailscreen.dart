import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen({Key? key}) : super(key: key);

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

  InputDecoration _buildInputDecoration(String labelText, String hintText, String? errorText) {
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

      final Email email = Email(
        body: 'HTML 파일 첨부',
        subject: 'HTML 파일',
        recipients: [recipient],
        isHTML: true,
        // TODO: Attach HTML file here
      );

      try {
        await FlutterEmailSender.send(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일이 성공적으로 발송되었습니다.'),
            duration: Duration(seconds: 3),
          ),
        );
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일 발송 중 오류가 발생하였습니다.'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      setState(() {
        _isSendingEmail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("이메일 발송"),
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
    decoration: _buildInputDecoration('이메일', '이메일을 입력하세요', null), // 초기 상태는 오류 없음(null)
    validator: (value) {
    if (value!.isEmpty) {
    return '이메일을 입력하세요';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text('전송'),
      ),
    ],
    ),
    ),
        ),
    );
  }
}

