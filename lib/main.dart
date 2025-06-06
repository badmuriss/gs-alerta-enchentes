import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/weather_api.dart';
import 'providers/water_level_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/theme_provider.dart'; // Novo provider
import 'services/notification_service.dart';
import 'ui/theme.dart';
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
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(), // Novo provider para o tema
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Alerta Enchentes',
      theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const HomeScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}