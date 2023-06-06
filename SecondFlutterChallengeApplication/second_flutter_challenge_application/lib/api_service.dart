import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const baseUrl = "http://worldtimeapi.org/api/America";

  Future<dynamic> _fetch(String sub) async {
    final response = await http.get(Uri.parse('$baseUrl$sub'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data ${response.request}');
    }
  }

  Future<List<dynamic>> fetchCities() async { return await _fetch(""); }
  Future<dynamic> fetchCityTime(String city) async { return await _fetch(city); }
}

