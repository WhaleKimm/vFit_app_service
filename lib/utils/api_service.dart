import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> sendImages(File personImage, File clothesImage) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('http://서버_IP:8000/process'));
    request.files.add(
        await http.MultipartFile.fromPath('real_image_file', personImage.path));
    request.files.add(
        await http.MultipartFile.fromPath('clothes_file', clothesImage.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // 응답 바이트 가져오기
      var responseData = await response.stream.toBytes();
      // 필요한 처리를 수행하거나 결과를 반환
      return http.Response.bytes(responseData, response.statusCode);
    } else {
      throw Exception('서버 요청 실패: ${response.statusCode}');
    }
  }
}
