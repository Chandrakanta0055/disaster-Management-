import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Auth/services/auth_services.dart';
import 'package:disaster_management/Features/User/Screens/homeScreen.dart';
import 'package:disaster_management/Model/userModel.dart';
import 'package:disaster_management/constants/globalVariables.dart';
 // Import UserProvider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart'; // Import Provider

class AccountCreateServices {

  void CreateAccount({
    required BuildContext context,
    required String email,
    required String phone,
    required String name,
    required String address,
    required String password,
  }) async {
    try {
      AuthServices services = AuthServices();
      await services.SignUpAccount(
        email: email,
        password: password,
        context: context,
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid.isEmpty) {
        ShowSnakbar("Failed to create user", context);
        return;
      }

      UserModel userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        phone: phone,
        profileImageUrl: "",
        role: "user",
        address: address,
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance.collection("user").doc(uid).set(userModel.toJson());
      // ✅ Get UserProvider instance and update Firestore & UI state

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.setUserData(userModel);

      ShowSnakbar("Account Created Successfully", context);

      // ✅ Navigate to HomeScreen after updating user data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );

    } catch (e) {
      print(e.toString());
      ShowSnakbar("Error: ${e.toString()}", context);
    }

  }
}
