import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Model/TaskModel.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/cupertino.dart';

class TaskServices{
  Future<void> assignTask({required TaskModel model,
    required BuildContext context})async{
    try
        {
         await FirebaseFirestore.instance.collection("Task").doc(model.id).set(model.toMap());
         print("save successfully");
         ShowSnakbar("Task Assign Successfully", context);
        }
        catch(e){
      print(e.toString());
      ShowSnakbar(e.toString(), context);

        }

  }
}