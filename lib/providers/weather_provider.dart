import 'package:flutter/material.dart';
import '../api/weather_api.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherApi _weatherApi;
  final LocationService _locationService = LocationService();
  
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  WeatherProvider(this._weatherApi);

  Future<void> fetchWeatherForCurrentLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentLocation();
      _weather = await _weatherApi.getWeather(position.latitude, position.longitude);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}