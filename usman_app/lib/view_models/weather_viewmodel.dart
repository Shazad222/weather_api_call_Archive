import 'package:flutter/material.dart';
import '../services/geocoding_api_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final GeocodingApiService _geocodingApiService = GeocodingApiService();

  Map<String, dynamic>? _cityData;
  String _errorMessage = '';
  bool _isLoading = false;

  Map<String, dynamic>? get cityData => _cityData;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchCityData(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final cityDetails = await _geocodingApiService.fetchCityDetails(cityName);
      _cityData = cityDetails;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to fetch city data: $e';
      _cityData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
