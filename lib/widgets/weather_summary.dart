import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherSummary extends StatelessWidget {
  final Weather weather;
  final VoidCallback onTap;

  const WeatherSummary({
    Key? key, 
    required this.weather,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getBackgroundColors(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${weather.cityName}, ${weather.country}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${weather.temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            weather.description[0].toUpperCase() + weather.description.substring(1),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.network(
                      weather.iconUrl,
                      width: 80,
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.cloud, size: 80, color: Colors.white70),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoColumn(
                      Icons.water_drop,
                      'Umidade',
                      '${weather.humidity}%',
                    ),
                    _buildInfoColumn(
                      Icons.cloud,
                      'Nebulosidade',
                      '${weather.cloudiness}%',
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Ver detalhes',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<Color> _getBackgroundColors() {
  if (weather.temperature > 30) {
      return [Color(0xFF2E7D32), Color(0xFF1B5E20)]; // Verde escuro (muito quente)
    } else if (weather.temperature > 25) {
      return [Color(0xFF388E3C), Color(0xFF2E7D32)]; // Verde médio-escuro (quente)
    } else if (weather.temperature > 20) {
      return [Color(0xFF43A047), Color(0xFF388E3C)]; // Verde médio (agradável)
    } else if (weather.temperature > 15) {
      return [Color(0xFF4CAF50), Color(0xFF43A047)]; // Verde normal (fresco)
    } else if (weather.temperature > 10) {
      return [Color(0xFF66BB6A), Color(0xFF4CAF50)]; // Verde claro (frio)
    } else {
      return [Color(0xFF81C784), Color(0xFF66BB6A)]; // Verde muito claro (muito frio)
    }
  }
}