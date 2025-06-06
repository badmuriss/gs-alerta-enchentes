import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/status_screen.dart';
import 'screens/simulation_screen.dart';
import 'screens/weather_screen.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield_outlined),
            activeIcon: Icon(Icons.shield),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_outlined),
            activeIcon: Icon(Icons.water_rounded),
            label: 'Simulação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat_outlined),
            activeIcon: Icon(Icons.thermostat),
            label: 'Clima',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}