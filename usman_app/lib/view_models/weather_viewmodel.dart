import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/geocoding_api_service.dart';
import '../services/weather_api_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final GeocodingApiService _geocodingApiService = GeocodingApiService();
  final WeatherApiService _weatherApiService = WeatherApiService();

  Map<String, dynamic>? _cityData;
  Weather? _weather;
  String _errorMessage = '';
  bool _isLoading = false;

  Map<String, dynamic>? get cityData => _cityData;
  Weather? get weather => _weather;
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

  Future<void> fetchWeather() async {
    if (_cityData == null) {
      _errorMessage = 'City data is not available';
      notifyListeners();
      return;
    }

    final double lat = double.parse(_cityData!['lat']);
    final double lon = double.parse(_cityData!['lon']);

    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherApiService.fetchWeather(lat, lon);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data: $e';
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
