class WeatherModel {
  final double lon;
  final double lat;
  final double temp;
  final String cityName;
  final String mainCondition;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.temp,
    required this.cityName,
    required this.mainCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lat: json['coord']['lat'].toDouble(),
      lon: json['coord']['lon'].toDouble(),
      temp: json['main']['temp'].toDouble(),
      cityName: json['name'],
      mainCondition: json['weather'][0]['main'],
    );
  }
}