import 'package:disaster_management/Features/Admin/Screens/report.dart';
import 'package:disaster_management/Features/Admin/Screens/work.dart';
import 'package:disaster_management/Features/User/Screens/ShowNotification.dart';
import 'package:disaster_management/Features/User/Screens/complain_box.dart';
import 'package:disaster_management/Features/User/Screens/feedBack.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:disaster_management/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Auth/Screens/sign_in_screen.dart';
import '../widgets/Content.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    List<String> items = [
      "Complain Box",
      "Notification",
      "Weather Updates",
      "Feed Back",
      "report",
      "work"

    ]; // Sample data for the grid

    return Scaffold(
      appBar:PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Container(
    color: Colors.transparent, // Make the container transparent/ Side margins
    child: ClipRRect(
    // borderRadius: const BorderRadius.only(
    // bottomLeft: Radius.circular(20),
    // bottomRight: Radius.circular(20),
    // ),

    child: AppBar(
    flexibleSpace: Container(
    decoration: BoxDecoration(
   color: BGColor
    ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
    FirebaseAuth.instance.signOut().then((val) {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
    });
    },
    child: const Text(
    "Government of India",
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    ),
    ),
    ),
    ),
    ),

    body:  Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.green, Colors.white], // Gradient from Green to White
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.all(25.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text("Hi,", style: TextStyle(fontSize: 20)),
    const SizedBox(height: 10),
    user == null
    ? const CircularProgressIndicator()
        : Text(
    "${user.name}",
    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 20),

    Expanded(
    child: SingleChildScrollView(
    child: Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.only(top: 20, bottom: 20),
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: GridView.builder(
    shrinkWrap: true, // ✅ Allows GridView to fit content
    physics: const NeverScrollableScrollPhysics(), // ✅ Prevents nested scrolling issues
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Two items per row
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 0.9, // Adjust height of grid items
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
    return Container(
    margin: const EdgeInsets.all(10),
    child: Content(
    text: items[index],
    color: Colors.black,
    bgColor: Colors.black12,
    callback: () {
      if(index == 0 )
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ComplainBox()));
        }
      else if(index ==1)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowNotification() ));

        }
      else if(index ==2)
      {



      }
      else if(index ==3)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> FeedbackWidget()));
      }
      else if(index == 4){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowReport()));

      }
      else if(index == 5){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Work()));

      }
    print("${items[index]} clicked!");
    },
    ),
    );
    },
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),

    );
  }
}
