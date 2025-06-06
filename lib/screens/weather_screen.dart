import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_info.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<WeatherProvider>();
      if (provider.weather == null && !provider.isLoading) {
         provider.fetchWeatherForCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildWeatherContent(weatherProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<WeatherProvider>().fetchWeatherForCurrentLocation(),
        tooltip: 'Atualizar Clima',
        icon: const Icon(Icons.refresh),
        label: const Text("Atualizar"),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherProvider provider) {
    if (provider.isLoading) {
      return const CircularProgressIndicator();
    } else if (provider.errorMessage != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 50),
          const SizedBox(height: 16),
          Text('Erro ao buscar clima: ${provider.errorMessage}', textAlign: TextAlign.center),
        ],
      );
    } else if (provider.weather != null) {
      return WeatherInfo(weather: provider.weather!);
    } else {
      return const Text('Clique em atualizar para buscar o clima.', textAlign: TextAlign.center);
    }
  }
}