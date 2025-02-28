import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Model/NotificationModel.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:disaster_management/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FeedBackServices{

  Future<void> GiveFeedBack({
    required BuildContext context,
    required double rating,
    required description
})async{
    final user = Provider.of<UserProvider>(context,listen: false).user;

    try {
      String id = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      NotificationModel model = NotificationModel(id: id,
          title: "Feed Back",
          description: description,
          imagePaths: [],
          location: "",
          dateSubmitted: Timestamp.now().toString(),
          senderId: user!.uid,
          category: "FeedBack",
          rating: rating,
      name:  user.name);

      await FirebaseFirestore.instance.collection("Notification").doc(id).set(
          model.toMap());
      print("feed back send successfully");
      ShowSnakbar("feed back send successfully", context);
    }
    catch(e){
      print(e.toString());

    }

  }
}