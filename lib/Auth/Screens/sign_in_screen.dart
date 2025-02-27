import 'package:disaster_management/Auth/Screens/sign_up_screen.dart';
import 'package:disaster_management/constants/CustomButton.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ShowSnakbar("Please enter all the fields", context);
      return;
    }

    setState(() {
      _isLoading = true; // Show loading state
    });

    try {
      AuthServices authServices = AuthServices();
      bool isSuccess = await authServices.SignInAccount(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );

      if (isSuccess) {
        ShowSnakbar("Login successful!", context);
      } else {
        ShowSnakbar("Login failed! Please check your credentials.", context);
      }
    } catch (e) {
      ShowSnakbar("Error: ${e.toString()}", context);
    } finally {
      setState(() {
        _isLoading = false; // Hide loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Create an Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 60),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter the Email",
                hintStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true, // Hides password input
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter the Password",
                hintStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Sign In",
              callback: signIn,
            ),

            Expanded(child: Container()),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
