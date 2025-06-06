import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_level_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/status_card.dart';
import '../widgets/weather_info.dart';
import 'safety_tips_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final weatherProvider = context.read<WeatherProvider>();
      if (weatherProvider.weather == null) {
        weatherProvider.fetchWeatherForCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final waterLevel = context.watch<WaterLevelProvider>().waterLevel;
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Visão Geral', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text('Status do Nível da Água (Simulado)', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            StatusCard(waterLevel: waterLevel),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Clima na sua Região', style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<WeatherProvider>().fetchWeatherForCurrentLocation(),
                  tooltip: 'Atualizar Clima',
                )
              ],
            ),
            const SizedBox(height: 8),
            _buildWeatherContent(weatherProvider),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.health_and_safety_outlined),
              label: const Text('Dicas de Segurança'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SafetyTipsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherProvider provider) {
    if (provider.isLoading) {
      return const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: CircularProgressIndicator()));
    } else if (provider.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text('Erro ao carregar o clima: ${provider.errorMessage}', textAlign: TextAlign.center, style: TextStyle(color: Colors.red.shade700)),
      );
    } else if (provider.weather != null) {
      return WeatherInfo(weather: provider.weather!);
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text('Clique em atualizar para buscar os dados.', textAlign: TextAlign.center),
      );
    }
  }
}