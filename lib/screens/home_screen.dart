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
  String formattedDateTime = "";
  String city = "Karachi";
  String city1 = "";
  var faviourte = [];
  var location = "Current Location";

  @override
 void initState() {
    super.initState();
    _updateTime();
    _fetchTemperature();
  }

Widget temperatureWidget(double? temperature) {
  return temperature == null
      ? CircularProgressIndicator()
      : Text(
          '${temperature.toStringAsFixed(1)}°C',
          style: TextStyle(fontSize: 70,color: Colors.white,fontWeight: FontWeight.w500),
        );
}

  void _updateTime() {
    final now = DateTime.now();
    formattedDateTime = DateFormat('EEEE,dd-MM-yyyy').format(now);
    setState(() {});
    Future.delayed(Duration(seconds: 1), () {
      _updateTime();
    });
  }

  Future<void> _fetchTemperature() async {
    final weatherService = WeatherService();
    final temp = await weatherService.getTemperature(city: 'Karachi');
    setState(() {
      temperature = temp;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Stack(
                children: [
                 Container(
                        margin: EdgeInsets.only(top: 50,left: 20),
                        child: Text("$city",style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.w800),),
                      ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 80),
                    child: Text("$location",style: TextStyle(color:Colors.white)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 290,top: 50),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.settings))
                ),
                Container(
                  margin: EdgeInsets.only(top: 140,left:110),
                 child: Text(
          formattedDateTime ?? '',
          style: TextStyle(fontSize: 15,color: Colors.white),
        ),
              ),
              Center(
                child: Container(
                  // color: Colors.white,
                  margin: EdgeInsets.only(bottom: 200),
                  child: temperatureWidget(temperature)),
              ),
                ]
              )),
          ],
        ),
    );
  }
}