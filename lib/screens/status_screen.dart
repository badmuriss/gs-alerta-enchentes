import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_level_provider.dart';
import '../widgets/status_card.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final waterLevel = context.watch<WaterLevelProvider>().waterLevel;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Condição Atual do Alerta', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              StatusCard(waterLevel: waterLevel),
            ],
          ),
        ),
      ),
    );
  }
}