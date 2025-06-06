import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class WaterLevelProvider with ChangeNotifier {
  double _waterLevel = 0.0;
  final NotificationService _notificationService;

  WaterLevelProvider(this._notificationService);

  double get waterLevel => _waterLevel;

  void setWaterLevel(double newLevel) {
    _waterLevel = newLevel.clamp(0.0, 100.0);

    if (_waterLevel >= 75.0) {
      _notificationService.showNotification(
        'ALERTA: PERIGO IMINENTE!',
        'Nível da água em ${_waterLevel.toStringAsFixed(0)}%. Risco alto de enchente.',
      );
    }
    notifyListeners();
  }
}