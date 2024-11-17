import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/weather_viewmodel.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    final TextEditingController latController = TextEditingController();
    final TextEditingController lonController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agro Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: latController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Latitude',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lonController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Longitude',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final lat = double.tryParse(latController.text);
                final lon = double.tryParse(lonController.text);

                if (lat != null && lon != null) {
                  viewModel.fetchWeather(lat, lon);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please enter valid latitude and longitude'),
                    ),
                  );
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.errorMessage.isNotEmpty)
              Text(
                viewModel.errorMessage,
                style: const TextStyle(color: Colors.red),
              )
            else if (viewModel.weather != null)
              Column(
                children: [
                  Text(
                    'Temperature: ${viewModel.weather!.temperature}°C',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Description: ${viewModel.weather!.description}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
