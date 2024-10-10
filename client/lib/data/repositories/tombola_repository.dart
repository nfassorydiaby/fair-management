import 'dart:convert';
import 'package:http/http.dart' as http;

class TombolaRepository {
  final String baseUrl = 'http://localhost:8000'; 

  Future<String> enterTombola(int studentId, int tickets) async {
    final response = await http.post(
      Uri.parse('$baseUrl/enter-tombola'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'student_id': studentId,
        'tickets': tickets,
      }),
    );

    if (response.statusCode == 200) {
      return 'Successfully entered the tombola';
    } else {
      throw Exception('Failed to enter tombola');
    }
  }

  Future<String> drawTombola() async {
    final response = await http.post(
      Uri.parse('$baseUrl/draw-tombola'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return 'Winner: ${json['winner']}, ID: ${json['id']}';
    } else {
      throw Exception('Failed to draw tombola');
    }
  }
}
