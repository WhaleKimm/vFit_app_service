import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class VirtualTryOnProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  Image? resultImage;

  Future<void> processImages(File personImage, File clothesImage) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.sendImages(personImage, clothesImage);
      resultImage = Image.memory(response.bodyBytes);
    } catch (e) {
      print('에러 발생: $e');
      // 에러 처리를 수행
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
