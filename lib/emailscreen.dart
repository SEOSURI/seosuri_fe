import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isLoading = false;
  bool _isEmailSent = false;

  Future<void> _createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Center(
          child: pw.Text('Hello, World!', style: pw.TextStyle(fontSize: 24)),
        );
      },
    ));

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
    _sendEmail(file);
  }

  Future<void> _sendEmail(File file) async {
    setState(() {
      _isLoading = true;
    });

    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: [file.path],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      setState(() {
        _isEmailSent = true;
      });
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email with PDF Attachment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_isEmailSent)
              Text('Email sent successfully!')
            else
              ElevatedButton(
                onPressed: _createPdf,
                child: Text('Send Email'),
              ),
          ],
        ),
      ),
    );
  }
}
