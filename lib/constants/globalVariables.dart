
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
var BGColor = CupertinoColors.systemYellow;
var textColor = Colors.white;
var black = Colors.black;

var appBarColor = Colors.green[100];
var Back = Colors.green[50];
var gradiant1 =  LinearGradient(
  colors: [ Colors.white,Colors.green], // Gradient from Green to White
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
var gradiant2 = LinearGradient(
  colors: [BGColor, Colors.white], // Gradient from Green to White
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

void ShowSnakbar(String  data,BuildContext context){

  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      padding: EdgeInsets.symmetric(vertical: 10),
      behavior: SnackBarBehavior.floating,

      elevation: 3,
        backgroundColor: Colors.white,
        content: Center(
          child: Text(data ,style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),),
        ))
  );
}

void _extractLocationParameters(String locationString) {
  // Split the string using '|'
  List<String> parts = locationString.split('|');
  if (parts.length >= 8) {
    String latitude = parts[0];
    String longitude = parts[1];
    String timestamp = parts[2];
    String accuracy = parts[3];
    String altitude = parts[4];
    String heading = parts[5];
    String speed = parts[6];
    String speedAccuracy = parts[7];
    print("Extracted Latitude: $latitude");

    print("Extracted Longitude: $longitude");

    print("Extracted Timestamp: $timestamp");

    print("Extracted Accuracy: $accuracy meters");

    print("Extracted Altitude: $altitude meters");

    print("Extracted Heading: $heading degrees");

    print("Extracted Speed: $speed m/s");

    print("Extracted Speed Accuracy: $speedAccuracy m/s");

  } else {

    print("Error: Invalid location string format");

  }

}


