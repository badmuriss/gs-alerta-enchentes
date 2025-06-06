import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherApi {
  final String apiKey;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherApi({required this.apiKey});

  Future<Weather> getWeather(double lat, double lon) async {
    final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar dados do clima. Status: ${response.statusCode}');
    }
  }
}