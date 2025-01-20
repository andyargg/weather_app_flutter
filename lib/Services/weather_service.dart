// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
    Future<Position> getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('El servicio de ubicación está deshabilitado');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error('Permisos de ubicación denegados');
          
        }
      }

      try {
        LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high, // Puedes elegir entre: high, medium, low, none
          distanceFilter: 10, // Mínima distancia entre actualizaciones (en metros)
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      return position;

    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
    throw Exception("No se pudo obtener la ubicación.");
  }

  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    const apiKey = 'a17f2378b387e9db60273a2d194f8f1f';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Si la respuesta es ok, se parsea el JSON
        return json.decode(response.body);
      } else {
        return {
        "mensaje": "Error: Status code ${response.statusCode}"
      };
      }
    } catch (e) {
        return {
          "mensaje": "Error en la solicitud: $e"
      };
    }
  }
}