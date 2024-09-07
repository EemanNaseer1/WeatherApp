import 'dart:convert';
import 'package:http/http.dart' as http;


class WeatherService {
  Future<Map<String, double>> getTemperature(String city) async {
    const apiKey = 'b664c8234758057c521c50b9ba675041'; // Replace with your API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double temperature = data['main']['temp'];
      double feelsLike = data['main']['feels_like'];
      return {'temperature': temperature, 'feelsLike': feelsLike};
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}