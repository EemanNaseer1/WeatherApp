import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/screens/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? temperature;
  double? feelsLike;
  String formattedDateTime = "";
  String city = "Karachi";
  String location = "Current Location";

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
    _fetchTemperature(); // Fetch temperature and feelsLike values.
  }

  // Widget to display the temperature and feels like values
  Widget temperatureWidget(double? temperature, double? feelsLike) {
    if (temperature == null || feelsLike == null) {
      return Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text(
            'Unable to fetch weather data',
            style: TextStyle(color: Colors.red),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${temperature.toStringAsFixed(1)}°C',
            style: TextStyle(
              fontSize: 42,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'Feels Like ${feelsLike.toStringAsFixed(1)}°C', // Display feels like temperature
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      );
    }
  }

  // Method to update the current date and time
  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      formattedDateTime = DateFormat('EEEE, dd-MM-yyyy').format(now);
    });
  }

  // Method to fetch the temperature and feels like values
  Future<void> _fetchTemperature() async {
    try {
      final weatherService = WeatherService(); // Assuming this is your weather fetching service
      final tempData = await weatherService.getTemperature(city); // Fetch temperature and feels like
      setState(() {
        temperature = tempData['temperature'] as double?;
        feelsLike = tempData['feelsLike'] as double?;
      });
    } catch (e) {
      // Handle error and set values to null
      setState(() {
        temperature = null;
        feelsLike = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/view.png"),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      city,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.17,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      location,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                      formattedDateTime,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 270),
                      child: temperatureWidget(temperature, feelsLike), // Pass both temperature and feelsLike
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 370),
                      child: Text("Cloudy",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                      ),),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
