import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/screens/home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> searchTexts = ["karachi"]; // Store multiple search texts
  Map<String, Map<String, double>> weatherData = {}; // Store weather data for each city
  String formattedDateTime = "";

  @override
  void initState() {
    super.initState();
    _updateTime();
    _fetchWeatherData(); // Fetch weather data for initial cities
  }

  void _updateTime() {
    final now = DateTime.now();
    formattedDateTime = DateFormat('EEEE,dd-MM-yyyy').format(now);
    setState(() {});
    Future.delayed(Duration(seconds: 1), () {
      _updateTime();
    });
  }

  Future<void> _fetchWeatherData() async {
    final weatherService = WeatherService();
    Map<String, Map<String, double>> fetchedWeatherData = {};

    for (String city in searchTexts) {
      final weather = await weatherService.getTemperature(city);
      fetchedWeatherData[city] = weather;
    }

    setState(() {
      weatherData = fetchedWeatherData;
    });
  }

  void _addCity(String city) {
    setState(() {
      searchTexts.add(city);
    });
    _fetchWeatherData(); // Fetch weather data for the new city
  }

  Widget temperatureWidget(double? temperature, double? feelsLike) {
    return temperature == null || feelsLike == null
        ? CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Text(
                'Feels Like ${feelsLike.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color.fromARGB(179, 72, 96, 230),
                    const Color.fromARGB(186, 92, 113, 231),
                    const Color.fromARGB(255, 160, 169, 221),
                    const Color.fromARGB(255, 188, 196, 236),
                    const Color.fromARGB(244, 255, 255, 255),
                    const Color.fromARGB(244, 255, 255, 255),
                    const Color.fromARGB(255, 255, 255, 255),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 130),
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color.fromARGB(179, 107, 125, 224),
                          const Color.fromARGB(184, 129, 143, 224),
                          const Color.fromARGB(255, 143, 155, 224),
                          const Color.fromARGB(255, 162, 171, 218),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Enter City",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                        suffix: IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.only(top: 20),
                            icon: Icon(Icons.add)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              _addCity(searchController.text); // Add city and fetch weather data
                              searchController.clear(); // Clear the text field after search
                            }
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // Displaying multiple containers for each search text with deletion functionality
                  Column(
                    children: searchTexts.map((text) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            searchTexts.remove(text);
                            weatherData.remove(text); // Remove the weather data of the dismissed city
                          });
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Stack(children: [
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              width: 300,
                              height: 90,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromARGB(179, 59, 71, 138),
                                    const Color.fromARGB(185, 132, 146, 223),
                                    const Color.fromARGB(255, 151, 163, 230),
                                    const Color.fromARGB(255, 162, 171, 218),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5, bottom: 10)),
                                  Text(
                                    '$text',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  temperatureWidget(weatherData[text]?['temperature'], weatherData[text]?['feelsLike']),
                                ],
                              )),
                        ]),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
