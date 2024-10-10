import 'dart:convert';
import '../models/stand_model.dart';
import 'package:http/http.dart' as http;

class StandRepository {
  final String baseUrl = 'http://localhost:8000';

  Future<List<Stand>> getAllStands() async {
    final response = await http.get(Uri.parse('$baseUrl/stands'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((stand) => Stand.fromJson(stand)).toList();
    } else {
      throw Exception('Failed to load stands');
    }
  }

  Future<void> addStand(String name, int stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-stand'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'stock': stock}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add stand');
    }
  }

  Future<void> updateStand(int id, String name, int stock) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/update-stand'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'stand_id': id, 'name': name, 'stock': stock}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update stand');
    }
  }
}
