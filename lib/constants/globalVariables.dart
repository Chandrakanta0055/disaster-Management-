
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


