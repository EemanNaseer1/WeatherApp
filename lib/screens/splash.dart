import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 380),
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