import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:5000/api/auth';
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(
      String emailOrUsername, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "emailOrUsername": emailOrUsername,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'token', value: data['token']);
      return {"success": true, "token": data['token']};
    } else {
      return {"success": false, "message": jsonDecode(response.body)['error']};
    }
  }

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return {"success": true, "message": jsonDecode(response.body)['message']};
    } else {
      return {"success": false, "message": jsonDecode(response.body)['error']};
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: 'token');
    if (token == null) return false;

    final response = await http.get(
      Uri.parse('$_baseUrl/validate'),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Add logic to validate the token (e.g., checking expiration)
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['valid'];
    }
    return false;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
