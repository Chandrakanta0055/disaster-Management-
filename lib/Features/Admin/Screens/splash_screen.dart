import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async'; // For Timer

class SplashScreen extends StatefulWidget {
  final Widget? nextScreen; // Optional: Navigate to next screen after splash

  SplashScreen({Key? key, this.nextScreen}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.nextScreen != null) {
      Timer(Duration(seconds: 3), () { // Reduced timer to 3 seconds
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widget.nextScreen!),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[900]!,Colors.white , Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                height: 100, // Adjust logo height as needed
              ),
              SizedBox(height: 20), // Add spacing between logo and text
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'resQ',
                    textStyle: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    speed: const Duration(milliseconds: 200), // Increased speed
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 600), // Reduced pause
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '"Preparedness is the ultimate prevention."',
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    speed: const Duration(milliseconds: 50), // Increased speed
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 500), // Reduced pause
              ),
            ],
          ),
        ),
      ),
    );
  }
}