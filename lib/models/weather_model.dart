class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final String iconCode;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDeg;
  final int visibility;
  final int cloudiness;
  final DateTime? sunrise;
  final DateTime? sunset;
  final String country;
  final DateTime lastUpdated;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.iconCode,
    this.feelsLike = 0.0,
    this.tempMin = 0.0,
    this.tempMax = 0.0,
    this.humidity = 0,
    this.pressure = 0,
    this.windSpeed = 0.0,
    this.windDeg = 0,
    this.visibility = 0,
    this.cloudiness = 0,
    this.sunrise,
    this.sunset,
    this.country = '',
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Não encontrado',
      description: json['weather']?[0]?['description'] ?? '',
      temperature: (json['main']?['temp'] as num?)?.toDouble() ?? 0.0,
      iconCode: json['weather']?[0]?['icon'] ?? '01d',
      feelsLike: (json['main']?['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['main']?['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['main']?['temp_max'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['main']?['humidity'] as num?)?.toInt() ?? 0,
      pressure: (json['main']?['pressure'] as num?)?.toInt() ?? 0,
      windSpeed: (json['wind']?['speed'] as num?)?.toDouble() ?? 0.0,
      windDeg: (json['wind']?['deg'] as num?)?.toInt() ?? 0,
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      cloudiness: (json['clouds']?['all'] as num?)?.toInt() ?? 0,
      country: json['sys']?['country'] ?? '',
      sunrise: json['sys']?['sunrise'] != null 
          ? DateTime.fromMillisecondsSinceEpoch((json['sys']['sunrise'] as int) * 1000)
          : null,
      sunset: json['sys']?['sunset'] != null 
          ? DateTime.fromMillisecondsSinceEpoch((json['sys']['sunset'] as int) * 1000)
          : null,
      lastUpdated: DateTime.now(),
    );
  }
  
  String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  
  String get windDirection {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    return directions[(((windDeg + 22.5) % 360) / 45).floor()];
  }
}