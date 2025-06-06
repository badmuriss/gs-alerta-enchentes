import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  const WeatherInfo({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weather.cityName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C - ${weather.description[0].toUpperCase()}${weather.description.substring(1)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Image.network(weather.iconUrl, width: 60, height: 60),
          ],
        ),
      ),
    );
  }
}