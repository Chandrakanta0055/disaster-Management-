import 'package:disaster_management/Auth/Screens/AccountCreateScreen.dart';
import 'package:disaster_management/Auth/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../../constants/CustomButton.dart';
import '../../constants/globalVariables.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  void signUp()async{
    AuthServices authServices = AuthServices();
    if(emailController.text.isEmpty || passwordController.text.isEmpty || conformPasswordController.text.isEmpty )
      {
        ShowSnakbar("please enter all the field", context);
        return ;
      }
    // authServices.SignUpAccount(email: emailController.text, password: passwordController.text, context: context);
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>AccountCreateScreen(email: email, Password: password)));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text("Sign Up ",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: textColor
            ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                  Navigator.pop(context);
                },
                child: Text("I have an Account  ",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.blue
                ),),
              ) ,
            ),

            SizedBox(height: 60,),

            TextFormField(
                style: TextStyle(color: Colors.white),

                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Enter the Email",
                    hintStyle: TextStyle(
                        color: textColor
                    ),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 2)
                    )
                ))
            ,
            SizedBox(height: 20,),
            TextFormField(
                style: TextStyle(color: Colors.white),

                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Enter the password",
                    hintStyle: TextStyle(
                        color: textColor
                    ),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 2)
                    )
                )),
            SizedBox(height: 20,),
            TextFormField(
                style: TextStyle(color: Colors.white),

                controller: conformPasswordController,
                decoration: InputDecoration(
                    hintText: "Conform  password",
                    hintStyle: TextStyle(
                        color: textColor
                    ),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 2)
                    )
                )),
            SizedBox(height: 40,),

            CustomButton(text: "Sign Up", callback: (){
              signUp();
            }),
            Expanded(child: Container()),


            SizedBox(height: 50,)





          ],
        ),
      ),
    );
  }
}
