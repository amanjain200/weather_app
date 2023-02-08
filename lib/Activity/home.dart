import 'dart:convert';
import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  void getData() async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=raipur&appid=3136263aae4d517940eaf3b089a2ea22"));
    Map data = jsonDecode(response.body);
    List weather_data = data["weather"];
    Map weather_main_data = weather_data[0];
    print(weather_data);
    print(weather_main_data);
  }

  @override
  void initState() {
    print("This is a init state");
    super.initState();
    getData();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("Set State called");
  }

  @override
  Widget build(BuildContext context) {
    Map info = {};
    info = ModalRoute.of(context).settings.arguments as Map;

    String temp = ((info["temp_value"]).toString()).substring(0,4);
    String icon = info["icon_value"];
    String getcity = info["city_value"];
    String hum = info["hum_value"];
    String des = info["des_value"];
    //String main = info["main_value"];
    String air_speed = ((info["air_speed_value"]).toString()).substring(0,4);


    var city_name = [
      "Mumbai",
      "Delhi",
      "Raipur",
      "Bhubaneswar",
      "Indore",
      "Chennai"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.red,
        ),
      ),*/
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.blue,
            ]
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue[800],
                  Colors.blue[200],
                ])),
            child: Column(
              children: [
                Container(
                  //search wala container

                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == ""){
                            print("Blank Search");
                          }
                          else{
                            Navigator.pushReplacementNamed(context, '/loading', arguments: {
                              "searchText" : searchController.text,
                            });
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(1, 2, 8, 1),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(width: 50,),
                            Column(
                              children: [
                                Text("$des", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                ),),
                                Text("in $getcity", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                ),),
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.wiThermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp", style: TextStyle(fontSize: 90),),
                                Text("C", style: TextStyle(fontSize: 30),)
                              ],
                            )

                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.wiDayWindy),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Text("$air_speed", style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("Km/hr"),

                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.wiHumidity),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Text("$hum", style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("Percent"),

                          ],
                        )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60,),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Text("Made by Aman", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("Data provided by openweathermap.org"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
