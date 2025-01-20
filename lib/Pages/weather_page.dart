import 'package:flutter/material.dart';
import '../Services/weather_service.dart';
import '../Models/weather_model.dart';
import 'package:geolocator/geolocator.dart';


class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _weatherInfo = "Cargando...";
  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  // Obtener los datos del clima
  Future<void> _getWeatherData() async {
    try {
      // Obtener la ubicación actual
      Position position = await weatherService.getCurrentLocation();
      double lat = position.latitude;
      double lon = position.longitude;

      // Obtener el clima usando las coordenadas
      var weatherData = await weatherService.getWeather(lat, lon);

      setState(() {
        _weatherInfo = "Temperatura: ${weatherData['main']['temp']}°C";
      });
    } catch (e) {
      setState(() {
        _weatherInfo = "Error al obtener los datos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Center(
        child: Text(_weatherInfo),
        
      ),
    );
  }
}
