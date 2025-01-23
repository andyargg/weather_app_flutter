import 'package:flutter/material.dart';
import '../Services/weather_service.dart';
import '../Models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherService weatherService = WeatherService();
  WeatherModel? _weather;

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

      // Mapear los datos al modelo
      WeatherModel weatherModel = WeatherModel.fromJson(weatherData);

      setState(() {
        _weather = weatherModel;
      });
    } catch (e) {
      setState(() {
        _weather = null; // Manejo de error
      });
    }
  }
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }


@override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Weather',
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[100]!, 
              Colors.white
            ],
          ),
        ),
        child: Center(
          child: _weather == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // City Name
                    Text(
                      _weather!.cityName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Lottie.asset(
                      getWeatherAnimation(_weather!.mainCondition),
                      width: 150,
                      height: 150,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      '${_weather!.temp}°C',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Main Condition
                    Text(
                      _weather!.mainCondition,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey[600],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                  ],
                ),
        ),
      ),
    );
  }
}