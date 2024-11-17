import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/weather_viewmodel.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agro Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // City Name Input
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Button to Fetch City Data
            ElevatedButton(
              onPressed: () async {
                final cityName = cityController.text;
                if (cityName.isNotEmpty) {
                  await viewModel.fetchCityData(cityName);
                }
              },
              child: const Text('Get City Data'),
            ),
            const SizedBox(height: 16),

            // Display the fetched city details
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.errorMessage.isNotEmpty)
              Text(
                viewModel.errorMessage,
                style: const TextStyle(color: Colors.red),
              )
            else if (viewModel.cityData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City Name: ${viewModel.cityData!['name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Country: ${viewModel.cityData!['countryName']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Population: ${viewModel.cityData!['population']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Latitude: ${viewModel.cityData!['lat']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Longitude: ${viewModel.cityData!['lon']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Button to Fetch Weather Data
                  ElevatedButton(
                    onPressed: () {
                      viewModel.fetchWeather();
                    },
                    child: const Text('Get Weather Data'),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            // Display Weather Data
            if (viewModel.weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'City Weather Data:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temperature: ${viewModel.weather!.temperature}°C',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Weather: ${viewModel.weather!.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Humidity: ${viewModel.weather!.humidity}%',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Wind Speed: ${viewModel.weather!.windSpeed} m/s',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
