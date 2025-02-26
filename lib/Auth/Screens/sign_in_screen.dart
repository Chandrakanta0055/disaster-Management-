import 'package:disaster_management/Auth/Screens/sign_up_screen.dart';
import 'package:disaster_management/constants/CustomButton.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn()async{
    AuthServices authServices = AuthServices();
    if(emailController.text.isEmpty || passwordController.text.isEmpty )
    {
      ShowSnakbar("please enter all the field", context);
    }
    authServices.SignInAccount(email: emailController.text, password: passwordController.text, context: context);
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
            Text("Sign In ",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: textColor
            ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));

                },
                child: Text("Create a Account ",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.blue
                ),),
              ) ,
            ),

            SizedBox(height: 60,),


            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
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
            SizedBox(height: 40,),

            CustomButton(text: "Sign In", callback: (){
              signIn();
            }),
            Expanded(child: Container()),


            SizedBox(height: 50,)



        
        
          ],
        ),
      ),
    );
  }
}
