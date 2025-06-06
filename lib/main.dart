import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/weather_api.dart';
import 'providers/water_level_provider.dart';
import 'providers/weather_provider.dart';
import 'services/notification_service.dart';
import 'home_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final notificationService = NotificationService();
  await notificationService.init();

  const String openWeatherApiKey = '74d05fd30f846d4e74758baea18e9e69'; 
  final weatherApi = WeatherApi(apiKey: openWeatherApiKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WaterLevelProvider(notificationService),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(weatherApi),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerta Enchentes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade700,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.amber.shade700,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 4.0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomeScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}