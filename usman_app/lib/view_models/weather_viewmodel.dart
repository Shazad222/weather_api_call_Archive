import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApiService _apiService = WeatherApiService();

  Weather? _weather;
  String _errorMessage = '';
  bool _isLoading = false;

  Weather? get weather => _weather;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(double lat, double lon) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _apiService.fetchWeather(lat, lon);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
