import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mausam/Worker/worker.dart';
import 'package:flutter_spinkit/src/spinning_circle.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String city = "Raipur";
  String temp = "NULL";
  String hum = "NULL";
  String air_speed = "NULL";
  String des = "NULL";
  String main = "NULL";
  String icon = "NULL";

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value" : main,
        "icon_value" : icon,
        "city_value" : city,
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Map search = ModalRoute.of(context).settings.arguments;
    if(search?.isNotEmpty ?? false){
      city = search["searchText"];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("assets/images/mausam_logo.png",
                height: 170,
                width: 170,
                ),
              SizedBox(height: 20,),
              Text("Mausam App", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white,),),
              SizedBox(height: 10,),
              Text("Made by Aman", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white,),),
              SizedBox(height: 30,),
              SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
            ],
          ),
        ),
      ),
          backgroundColor: Colors.blue[300],
    );
  }
}
