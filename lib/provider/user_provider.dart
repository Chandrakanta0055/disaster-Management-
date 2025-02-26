import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/userModel.dart';// Import your UserModel

class UserProvider with ChangeNotifier {
  UserModel? _userModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? get user => _userModel;

  /// Fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot snapshot =
      await _firestore.collection("user").doc(currentUser.uid).get();

      if (snapshot.exists) {
        _userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
    }
  }

  /// Listens to authentication changes and updates user data
  void listenToAuthChanges() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await fetchUserData();
      } else {
        _userModel = null;
      }
      notifyListeners();
    });
  }

  /// 🔹 Set (Update) User Data in Firestore
  Future<void> setUserData(UserModel userModel) async {
    try {
      await _firestore.collection("user").doc(userModel.uid).set(userModel.toJson(), SetOptions(merge: true));
      _userModel = userModel;
      notifyListeners();
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
}
