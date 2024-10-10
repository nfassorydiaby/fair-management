import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenRepository {
  final String baseUrl = 'http://localhost:8000'; 

  Future<String> buyTokens(int parentId, int amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/buy-tokens'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'parent_id': parentId, 'amount': amount}),
    );

    if (response.statusCode == 200) {
      return 'Tokens bought successfully';
    } else {
      throw Exception('Failed to buy tokens');
    }
  }

  Future<String> distributeTokens(int parentId, int childId, int tokenCount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/distribute-tokens'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'parent_id': parentId,
        'student_id': childId,
        'token_count': tokenCount,
      }),
    );

    if (response.statusCode == 200) {
      return 'Tokens distributed successfully';
    } else {
      throw Exception('Failed to distribute tokens');
    }
  }
}
