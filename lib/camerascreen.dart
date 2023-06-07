import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seosuri_fe/Models/check_provider.dart';
import 'dart:io';
import 'checkscreen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final picker = ImagePicker();
  File? _image;

  List<scProblemData> data = getTextList();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              List<scProblemData> scproblemDataList = data;
              return CheckScreen(data: scproblemDataList, imageFile: _image);
            },
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '문제지를 생성할 문제 선택하기',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'nanum-square',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 285,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                ),
                onPressed: () => _pickImage(ImageSource.camera),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '카메라에서 사진 촬영하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nanum-square',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100), // 버튼 간의 수직 간격 조정
            Container(
              width: 285,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_album_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '앨범에서 사진 선택하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'nanum-square',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}