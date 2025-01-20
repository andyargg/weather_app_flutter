import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './Pages/weather_page.dart';

void main() async {
  await dotenv.load();  // Cargar las variables del archivo .env
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherPage(),  // Asegúrate de que WeatherPage esté importada
    );
  }
}