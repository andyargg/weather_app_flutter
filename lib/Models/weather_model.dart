class WeatherModel {
  final double lon;
  final double lat;
  final double temp;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.temp
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      temp: json['current']['temp'].toDouble()
    );
  }
}

