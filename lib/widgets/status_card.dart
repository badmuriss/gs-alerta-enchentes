import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final double waterLevel;

  const StatusCard({Key? key, required this.waterLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    String message;
    Color cardColor;
    IconData icon;

    if (waterLevel >= 75) {
      title = 'PERIGO IMINENTE';
      message = 'Risco alto de enchente. Procure um local seguro.';
      cardColor = Colors.red.shade700;
      icon = Icons.dangerous_outlined;
    } else if (waterLevel >= 50) {
      title = 'ALERTA';
      message = 'Nível da água elevado. Fique atento e preparado.';
      cardColor = Colors.orange.shade700;
      icon = Icons.warning_amber_rounded;
    } else {
      title = 'NORMAL';
      message = 'Nenhum risco de enchente detectado.';
      cardColor = Colors.green.shade700;
      icon = Icons.check_circle_outline_rounded;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(message, style: const TextStyle(color: Colors.white, fontSize: 15), softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}