import 'package:disaster_management/Auth/Screens/AccountCreateScreen.dart';
import 'package:disaster_management/Features/Home/homeScreen.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthServices{
  FirebaseAuth auth = FirebaseAuth.instance;
  Future SignUpAccount({
    required String email,
    required String password,
    required BuildContext context
}) async
{
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if(userCredential.user!= null){
      ShowSnakbar("Account Create Successfully", context);
    }
    else{
      ShowSnakbar("error found", context);
    }

  }
  on FirebaseAuthException  catch (e){
    ShowSnakbar(e.toString(), context);
  }
  catch(e){
    ShowSnakbar(e.toString(), context);
  }
}

  void SignInAccount({
    required String email,
    required String password,
    required BuildContext context
  }) async
  {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(userCredential.user!= null){
        ShowSnakbar("Account Login Successfully", context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()));
      }
      else{
        ShowSnakbar("error found", context);
      }

    }
    on FirebaseAuthException  catch (e){
      ShowSnakbar(e.toString(), context);
    }
    catch(e){
      ShowSnakbar(e.toString(), context);
    }
  }





}