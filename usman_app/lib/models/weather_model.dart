class Weather {
  final double temperature;
  final String description;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.humidity,
  });

  // Factory constructor to parse API response into Weather object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
    );
  }
}
