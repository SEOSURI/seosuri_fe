import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'checkscreen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final picker = ImagePicker();
  File? _image;

  final faker = Faker();
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    generateData();
  }

  void generateData() {
    for (int i = 0; i < 4; i++) {
      data.add(faker.lorem.sentence());
    }
  }

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
            builder: (context) => CheckScreen(data: data,imageFile: _image),
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
            '사진 선택',
          style: TextStyle(
            fontSize: 19
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 325,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  '카메라에서 사진 촬영하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'nanum-square'
                  ),
                ),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ),
            Container(
              width: 325, // 가로 크기를 200으로 설정
              height: 50, // 세로 크기를 50으로 설정
              child: ElevatedButton(
                child: Text(
                    '앨범에서 사진 선택하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'nanum-square'
                  ),
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ),
    );
  }
}