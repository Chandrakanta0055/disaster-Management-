
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
var BGColor = CupertinoColors.systemYellow;
var textColor = Colors.white;

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


