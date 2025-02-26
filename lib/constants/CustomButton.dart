import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Color color;
  final Color bgColor;
  const CustomButton({super.key, required this.text, required this.callback,  this.color = Colors.black, this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: bgColor
          ),
          onPressed: callback,
          child: Text(text,style: TextStyle(fontSize: 14,color: color, fontWeight: FontWeight.bold), )),
    );
  }
}
