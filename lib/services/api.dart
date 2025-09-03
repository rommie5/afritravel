import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/v1'; // Change to your server IP

  // Get token from shared preferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Generic GET request
  static Future<dynamic> get(String endpoint) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      },
    );

    return _handleResponse(response);
  }

  // Generic POST request
  static Future<dynamic> post(String endpoint, dynamic data) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    return _handleResponse(response);
  }

  // Handle response
  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Unauthorized');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Server error');
      default:
        throw Exception('Something went wrong');
    }
  }

  // Auth methods
  static Future<dynamic> login(String email, String password) async {
    final response = await post('auth/login', {
      'email': email,
      'password': password,
    });

    // Save token
    if (response['success'] && response['token']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
    }

    return response;
  }

  static Future<dynamic> register(String name, String email, String password) async {
    final response = await post('auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response['success'] && response['token']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
    }

    return response;
  }

  // Destination methods
  static Future<dynamic> getDestinations() async {
    return await get('destinations');
  }

  static Future<dynamic> getDestination(String id) async {
    return await get('destinations/$id');
  }

  // User methods
  static Future<dynamic> getUserProfile() async {
    return await get('users/me');
  }

  static Future<dynamic> updateUserProfile(Map<String, dynamic> data) async {
    return await post('users/update-profile', data);
  }
}