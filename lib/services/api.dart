import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/place.dart';
import '/models/category.dart';
import '../models/event.dart';
import '../models/tour.dart';
import './auth_service.dart';

class ApiService {
  static Future<List<dynamic>> getPlaces() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$API_BASE_URL/places'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load places');
    }
  }
}



  // Generic GET request with error handling
   Future<dynamic> _getRequest(String endpoint) async {
    final url = Uri.parse('$API_BASE_URL/$endpoint');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        // Try to parse server error message
        final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Error $endpoint: $error');
      }
    } catch (e) {
      throw Exception('Failed to fetch $endpoint: $e');
    }
  }

  // ===== PLACES =====
   Future<List<Place>> getPlaces() async {
    final data = await _getRequest('places');
    return (data as List).map((item) => Place.fromJson(item)).toList();
  }

  // ===== CATEGORIES =====
   Future<List<Category>> getCategories() async {
    final data = await _getRequest('categories');
    return (data as List).map((item) => Category.fromJson(item)).toList();
  }

  // ===== TRENDING TOURS =====
   Future<List<Tour>> getTrendingTours() async {
    final data = await _getRequest('trending-tours');
    return (data as List).map((item) => Tour.fromJson(item)).toList();
  }

  // ===== UPCOMING EVENTS =====
   Future<List<Event>> getEvents() async {
    final data = await _getRequest('events');
    return (data as List).map((item) => Event.fromJson(item)).toList();
  }
