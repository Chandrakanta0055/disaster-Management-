import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Auth/Screens/AccountCreateScreen.dart';
import 'package:disaster_management/Auth/Screens/sign_in_screen.dart';
import 'package:disaster_management/Features/Home/homeScreen.dart';
import 'package:disaster_management/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Model/userModel.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()..listenToAuthChanges()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return userProvider.user != null ? const Homescreen() : const SignInScreen();
        },
      ),
    );
  }
}





//
// class AuthManage extends StatelessWidget {
//   const AuthManage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator()); // Show loading indicator
//         }
//
//         if (snapshot.hasData && snapshot.data != null) {
//           return const MyHomeScreen(); // User is signed in
//         } else {
//           return const MyApp(); // User is not signed in
//         }
//       },
//     );
//   }
// }

// Wrap Homescreen inside MaterialApp
class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homescreen(),
    );
  }
}
