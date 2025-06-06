class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Não encontrado',
      description: json['weather'][0]['description'] ?? '',
      temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      iconCode: json['weather'][0]['icon'] ?? '01d',
    );
  }
  
  String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}