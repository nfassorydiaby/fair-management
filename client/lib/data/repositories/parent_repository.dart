import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parent_model.dart';

class ParentRepository {
  final String baseUrl = 'http://localhost:8000/get-children';

  Future<Parent> fetchParentChildren(int parentId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'parent_id': parentId}),
    );

    if (response.statusCode == 200) {
      return Parent.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load children');
    }
  }
}
