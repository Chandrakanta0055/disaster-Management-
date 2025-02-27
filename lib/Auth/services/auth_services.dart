import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Auth/Screens/AccountCreateScreen.dart';
import 'package:disaster_management/Features/User/Screens/homeScreen.dart';
import 'package:disaster_management/Model/userModel.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:disaster_management/provider/user_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Future<bool> SignInAccount({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool isSuccess = false;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        ShowSnakbar("Account Login Successfully", context);
        final uid = userCredential.user!.uid;

        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("user")
            .doc(uid)
            .get();

        if (!snap.exists) {
          ShowSnakbar("User data not found!", context);
          return isSuccess;
        }

        UserModel userModel =
        UserModel.fromJson(snap.data() as Map<String, dynamic>);

        UserProvider provider =
        Provider.of<UserProvider>(context, listen: false);
        provider.setUserData(userModel);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homescreen()));
        isSuccess= true;

      } else {
        ShowSnakbar("Error logging in", context);
      }
    } on FirebaseAuthException catch (e) {
      ShowSnakbar(e.message ?? "Authentication error", context);
    } catch (e) {
      ShowSnakbar("An unexpected error occurred", context);
    }
    return isSuccess;
  }






}