// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // static const String _baseUrl = 'http://localhost:5000/api'; // dev
  static const String _baseUrl = 'https://resolve-api.vercel.app/api'; // prod
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {"success": true, "message": data['message']};
    } else {
      return {"success": false, "message": data['message']};
    }
  }

  Future<Map<String, dynamic>> login(
      String emailOrUsername, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "emailOrUsername": emailOrUsername,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await _storage.write(key: 'token', value: data['token']);

      // Fetch user details after successful login
      final userData = await _getUserDetails(data['token']);
      return {
        "success": true,
        "token": data['token'],
        "message": data['message'],
        "user": userData,
      };
    } else {
      return {"success": false, "message": data['message']};
    }
  }

  Future<Map<String, dynamic>> _getUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/profile/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Assuming the API returns user data
    } else {
      return {}; // Return empty if the request fails
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

  // function to submit a problem
  Future<Map<String, dynamic>> submitProblem(
      Map<String, dynamic> problemData) async {
    final token = await _storage.read(key: 'token');
    if (token == null) {
      return {"success": false, "message": "User not authenticated"};
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/problems'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(problemData),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {"success": true, "data": data};
    } else {
      return {
        "success": false,
        "message": data['message'] ?? 'Submission failed'
      };
    }
  }
}
