import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/screens/search_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen())),
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
                ])
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/images/cloud.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
              child: Text("WEATHER FORECAST",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w800),),
                  )
                ],
              )),
          ],
        ),
      ),
    );
  }
}