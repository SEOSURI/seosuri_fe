import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EmailScreen extends StatefulWidget {
  final File pdfFile;
  EmailScreen({Key? key, required this.pdfFile}) : super(key: key);


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
                decoration: InputDecoration(
                  labelText: '이메일',
                  hintText: '이메일을 입력하세요',
                ),
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailScreen(pdfFile: widget.pdfFile)));
                },
                child: Text('PDF 파일 이메일로 보내기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSendingEmail = true;
      });

      final recipient = _emailController.text.trim();

      final appDir = await getApplicationDocumentsDirectory();
      final filename = basename(widget.pdfFile.path);

      final Email email = Email(
        body: 'PDF 파일 첨부',
        subject: 'PDF 파일',
        recipients: [recipient],
        attachmentPaths: [join(appDir.path, filename)],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text('이메일이 성공적으로 발송되었습니다.'),
          duration: Duration(seconds: 3),
        ));
        Navigator.of(context as BuildContext).pop();
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text('이메일 발송 중 오류가 발생하였습니다.'),
          duration: Duration(seconds: 3),
        ));
      }

      setState(() {
        _isSendingEmail = false;
      });
    }
  }
}
