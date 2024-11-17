import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view_models/weather_viewmodel.dart';
import 'views/weather_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Weather App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const WeatherScreen(),
    );
  }
}
