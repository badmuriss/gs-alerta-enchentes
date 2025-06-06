import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_info.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

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
      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<WeatherProvider>().fetchWeatherForCurrentLocation();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 
                   AppBar().preferredSize.height - 
                   MediaQuery.of(context).padding.top,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildWeatherContent(weatherProvider),
              ),
            ),
          ),
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
      return const Center(child: CircularProgressIndicator());
    } else if (provider.errorMessage != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 50),
          const SizedBox(height: 16),
          Text('Erro ao buscar clima: ${provider.errorMessage}', 
               textAlign: TextAlign.center,
               style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => provider.fetchWeatherForCurrentLocation(),
            child: const Text('Tentar novamente'),
          ),
        ],
      );
    } else if (provider.weather != null) {
      return WeatherInfo(weather: provider.weather!);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_queue, size: 70, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma informação de clima disponível',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => provider.fetchWeatherForCurrentLocation(),
            child: const Text('Buscar clima atual'),
          ),
        ],
      );
    }
  }
}