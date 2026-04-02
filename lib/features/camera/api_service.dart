import 'dart:convert';
import 'package:http/http.dart' as http;

class CameraApiService {
  final String baseUrl = 'http://YOUR_PC_IP:5000/api'; // حطي IP جهازك

  Future<List> getCameras() async {
    final response = await http.get(Uri.parse('$baseUrl/cameras'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cameras');
    }
  }

  Future<List> getRecordings(int cameraId) async {
    final response = await http.get(Uri.parse('$baseUrl/cameras/$cameraId/recordings'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load recordings');
    }
  }
}