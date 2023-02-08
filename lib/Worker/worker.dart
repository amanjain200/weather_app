import 'dart:convert';

import 'package:http/http.dart';


class Worker {
  String location;
  //constructor
  Worker({this.location}){
    location = this.location;
  }

  String temp = "NULL";
  String humidity = "NULL";
  String air_speed = "NULL";
  String description = "NULL";
  String main = "NULL";
  String icon = "09d";

  Future<void> getData() async {
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=3136263aae4d517940eaf3b089a2ea22"));
      Map data = jsonDecode(response.body);

      //getting temp and humidity
      Map temp_data = data["main"];
      String getHumidity = temp_data["humidity"].toString();
      double getTemp = temp_data["temp"] - 273.15;

      //getting air speed
      Map wind = data["wind"];
      double getAir_speed = wind["speed"]/0.27777777777;

      //getting description
      List weather_data = data["weather"];
      Map weather_main_data = weather_data[0];
      String getMain_desc = weather_main_data["main"];
      String getDesc = weather_main_data["description"];

      //getting icon
      icon = weather_main_data["icon"].toString();

      //Assigning values
      temp = getTemp.toString(); //degree C
      humidity = getHumidity; //percent
      air_speed = getAir_speed.toString();  //km per hr
      description = getDesc;
      main = getMain_desc;
    } catch(e){

    }


  }

}