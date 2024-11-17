import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingApiService {
  static const String baseUrl = 'http://api.geonames.org/searchJSON';
  static const String username = 'shahzaddawkins'; // Your GeoNames username

  // Fetch city details based on the city query
  Future<Map<String, dynamic>> fetchCityDetails(String query) async {
    final url = Uri.parse('$baseUrl?q=$query&maxRows=1&username=$username');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['geonames'] != null && json['geonames'].isNotEmpty) {
        final geoData = json['geonames'][0];
        return {
          'name': geoData['name'],
          'countryName': geoData['countryName'],
          'population': geoData['population'],
          'lat': geoData['lat'],
          'lon': geoData['lng'],
        };
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to fetch city data');
    }
  }
}
