import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class AuthService {
  // Signup
  static Future<User> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    // if (response.statusCode != 201) {
    //   throw Exception('Signup failed: ${response.body}');
    // }
    // final data = jsonDecode(response.body);
    // await _storeToken(data['token']);
    // return User.fromJson(data['user']);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await _storeToken(data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Signup failed: ${response.body}');
    }
  }

  // Login
  static Future<User> loginn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/loginn'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storeToken(data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Store JWT
  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // Get JWT
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
