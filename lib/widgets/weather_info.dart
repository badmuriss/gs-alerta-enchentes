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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com cidade e temperatura principal
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather.cityName}, ${weather.country}', 
                        style: const TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        )
                      ),
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
            
            const Divider(height: 24),
            
            // Sensação térmica, mínima e máxima
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.thermostat_outlined, 
                  'Sensação', 
                  '${weather.feelsLike.toStringAsFixed(1)}°C'
                ),
                _buildInfoItem(
                  Icons.arrow_downward, 
                  'Mínima', 
                  '${weather.tempMin.toStringAsFixed(1)}°C'
                ),
                _buildInfoItem(
                  Icons.arrow_upward, 
                  'Máxima', 
                  '${weather.tempMax.toStringAsFixed(1)}°C'
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Umidade e pressão
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.water_drop_outlined, 
                  'Umidade', 
                  '${weather.humidity}%'
                ),
                _buildInfoItem(
                  Icons.compress, 
                  'Pressão', 
                  '${weather.pressure} hPa'
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Vento e visibilidade
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.air, 
                  'Vento', 
                  '${weather.windSpeed.toStringAsFixed(1)} m/s ${weather.windDirection}'
                ),
                _buildInfoItem(
                  Icons.visibility_outlined, 
                  'Visibilidade', 
                  '${(weather.visibility / 1000).toStringAsFixed(1)} km'
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Nebulosidade
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.cloud, 
                  'Nebulosidade', 
                  '${weather.cloudiness}%'
                ),
              ],
            ),
            
            // Nascer e pôr do sol (se disponíveis)
            if (weather.sunrise != null && weather.sunset != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(
                    Icons.wb_sunny_outlined, 
                    'Nascer do sol', 
                    _formatTime(weather.sunrise!)
                  ),
                  _buildInfoItem(
                    Icons.nightlight_outlined, 
                    'Pôr do sol', 
                    _formatTime(weather.sunset!)
                  ),
                ],
              ),
            ],
            
            // Última atualização
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Atualizado em: ${_formatDateTime(weather.lastUpdated)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.blue.shade700),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}