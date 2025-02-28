import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/constants/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Model/TaskModel.dart';
import '../../../constants/globalVariables.dart';

class Mytask extends StatelessWidget {
  const Mytask({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Task"),
        backgroundColor: appBarColor,
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Task").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            // Filter tasks where the current user is in the users list
            var tasks = snapshot.data!.docs.where((doc) {
              TaskModel model = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
              return model.users.contains(currentUserId);
            }).toList();

            if (tasks.isEmpty) {
              return Center(child: Text("No tasks assigned to you."));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                TaskModel model = TaskModel.fromMap(tasks[index].data() as Map<String, dynamic>);
                return InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Task is completed"),
                        actions: [
                          Container(
                            width: 100,
                            child: CustomButton(text: "ok", callback: () async{
                             await  FirebaseFirestore.instance.collection("Task").doc(model.id).update({
                                "status":"Complete"
                              });
                             Navigator.pop(context);
                            }),
                          )
                        ],
                      );
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(model.title),
                      subtitle: Text(model.description),
                      trailing: Text(model.status),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
