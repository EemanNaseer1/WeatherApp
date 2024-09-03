import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

TextEditingController searchcontroller = TextEditingController();

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
                  ])
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 130),
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                          prefix: IconButton(onPressed: (){
                            if(searchcontroller == "karachi"){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            } else {
                              print("no city found");
                            }
                          }, icon: Icon(Icons.search))
                        ),
                      ),
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}