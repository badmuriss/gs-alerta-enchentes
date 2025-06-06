import 'package:alerta_enchentes_novo/screens/simulation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'ui/icons.dart';
import 'ui/theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/status_screen.dart';
import 'screens/weather_screen.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedIndex = 0;

  static const List<String> _appBarTitles = <String>[
    'Dashboard',
    'Status do Alerta',
    'Simulação Nível d\'Água',
    'Clima Atual',
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    StatusScreen(),
    SimulationScreen(),
    WeatherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode ? AppTheme.darkGradient : AppTheme.lightGradient,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              color: isDarkMode ? AppTheme.primaryGreen : AppTheme.secondaryGreen,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: isDarkMode ? 'Mudar para tema claro' : 'Mudar para tema escuro',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
                ? [AppTheme.primaryBlack, AppTheme.darkGray]
                : [AppTheme.lightBackground, AppTheme.white],
          ),
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppTheme.darkGradient : AppTheme.lightGradient,
          boxShadow: isDarkMode ? AppTheme.elevatedShadow : AppTheme.lightCardShadow,
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.transparent,
          indicatorColor: (isDarkMode ? AppTheme.primaryGreen : AppTheme.secondaryGreen).withAlpha(50),
          destinations: const [
            NavigationDestination(
              icon: Icon(AppIcons.dashboard),
              selectedIcon: Icon(AppIcons.dashboardFilled),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.shield),
              selectedIcon: Icon(AppIcons.shieldFilled),
              label: 'Status',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.water),
              selectedIcon: Icon(AppIcons.waterFilled),
              label: 'Simulação',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.weather),
              selectedIcon: Icon(AppIcons.temperature),
              label: 'Clima',
            ),
          ],
        ),
      ),
    );
  }
}