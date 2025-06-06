import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_level_provider.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final waterLevelProvider = context.watch<WaterLevelProvider>();
    final waterLevel = waterLevelProvider.waterLevel;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nível da Água: ${waterLevel.toStringAsFixed(0)}%', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),
            Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade300, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: waterLevel / 100,
                    child: Container(color: Colors.blue.shade600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Slider(
              value: waterLevel,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${waterLevel.round()}%',
              onChanged: (double value) {
                context.read<WaterLevelProvider>().setWaterLevel(value);
              },
            ),
            const SizedBox(height: 10),
            const Text('Arraste para simular o nível da água.', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}