class Weather {
  final double temperature;
  final String description;

  Weather({
    required this.temperature,
    required this.description,
  });

  // Factory constructor to create a Weather object from API response
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }
}
