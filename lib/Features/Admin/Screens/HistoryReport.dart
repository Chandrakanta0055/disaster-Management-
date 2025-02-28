import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Model/TaskModel.dart';
import '../../../constants/globalVariables.dart';

class HistoryReport extends StatelessWidget {
  const HistoryReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Report"),
        backgroundColor: appBarColor,
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Task")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  TaskModel model = TaskModel.fromMap(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>);
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                        title: Text(model.title),
                        subtitle: Container(child: Text(model.description)),
                        trailing: Text("${model.status}")
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }
}
