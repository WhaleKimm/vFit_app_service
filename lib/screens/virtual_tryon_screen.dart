import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/virtual_tryon_provider.dart';

class VirtualTryOnScreen extends StatefulWidget {
  const VirtualTryOnScreen({Key? key}) : super(key: key);

  @override
  _VirtualTryOnScreenState createState() =>
      _VirtualTryOnScreenState(); // 여기에서 State를 올바르게 반환
}

class _VirtualTryOnScreenState extends State<VirtualTryOnScreen> {
  // 여기는 StatefulWidget과 연결되는 State 클래스
  File? _personImage;
  File? _clothesImage;

  Future<void> _pickImage(bool isPerson) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isPerson) {
          _personImage = File(pickedFile.path);
        } else {
          _clothesImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final virtualTryOnProvider = Provider.of<VirtualTryOnProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('가상 피팅')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (virtualTryOnProvider.isLoading)
            CircularProgressIndicator()
          else if (_personImage != null &&
              _clothesImage != null &&
              virtualTryOnProvider.resultImage != null)
            Center(child: virtualTryOnProvider.resultImage!)
          else if (_personImage != null && _clothesImage != null)
            ElevatedButton(
              onPressed: () {
                virtualTryOnProvider.processImages(
                    _personImage!, _clothesImage!);
              },
              child: Text('가상 피팅 시작'),
            )
          else if (_personImage != null &&
              _clothesImage != null &&
              virtualTryOnProvider.resultImage != null)
            Center(
                child: virtualTryOnProvider.resultImage ??
                    Container()) // 만약 resultImage가 null이라면 빈 컨테이너 반환
          else ...[
            ElevatedButton(
              onPressed: () => _pickImage(true),
              child: Text('사람 이미지 선택'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(false),
              child: Text('옷 이미지 선택'),
            ),
          ],
        ],
      ),
    );
  }
}
