import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Features/Admin/Services/AssignTaskServices.dart';
import 'package:disaster_management/Model/TaskModel.dart';
import 'package:disaster_management/constants/CustomButton.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:disaster_management/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/UserModel.dart';

class Work extends StatefulWidget {
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}
class _TaskListWidgetState extends State<Work> {
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  List<String> users = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        backgroundColor: appBarColor,
        actions: [
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: TextFormField(
                      controller: taskNameController,
                      style: TextStyle(color: black),
                      decoration: InputDecoration(
                        hintText: "Task Name:",
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                      ),
                    ),
                    content: Container(
                      height: 300,
                      child: Column(
                        children: [
                          // User selection
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Select Users"),
                                      content: Container(
                                        height: 300,
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("user")
                                              .where("role", isEqualTo: "G/S")
                                              .snapshots(),
                                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(child: CircularProgressIndicator());
                                            }
                                            return ListView.builder(
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                UserModel user = UserModel.fromJson(
                                                    snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                                bool isSelected = users.contains(user.uid);


                                                return ListTile(
                                                  title: Text(user.name),
                                                  subtitle: Text(user.phone),
                                                  trailing: isSelected
                                                      ? Icon(Icons.check_circle, color: Colors.green)
                                                      : Icon(Icons.add_circle_outline),
                                                  onTap: () {
                                                    setState(() {
                                                      if (isSelected) {
                                                        users.remove(user.uid);
                                                      } else {
                                                        users.add(user.uid);
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Done"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text("Add Member"),
                                  SizedBox(width: 5),
                                  Icon(Icons.add_circle),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Show selected users
                          Wrap(
                            spacing: 8.0,
                            children: users.map((userId) {
                              return Chip(
                                label: Text(userId), // Replace with user name if needed
                                onDeleted: () {
                                  setState(() {
                                    users.remove(userId);
                                  });
                                },
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 10),
                          // Task Description
                          Container(
                            height: 200,
                            child: TextFormField(
                              controller: descriptionController,
                              style: TextStyle(color: Colors.black38),
                              decoration: InputDecoration(
                                hintText: "Work Description",
                                hintStyle: TextStyle(color: Colors.black38),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "Cancel",
                              callback: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              text: "OK",
                              callback: () {
                                Navigator.pop(context);
                                String id = DateTime.now().millisecondsSinceEpoch.toString();
                                TaskModel model = TaskModel(
                                  phone: user!.phone,
                                  id: id,
                                  title: taskNameController.text.trim(),
                                  description: descriptionController.text.trim(),
                                  location: "",
                                  dateSubmitted: DateTime.now().toString(),
                                  senderId: user.uid,
                                  category: "Task",
                                  name: "Admin",
                                  users: users,
                                );
                                TaskServices services = TaskServices();
                                services.assignTask(model: model, context: context);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              );
            }
            ,
            child: Icon(Icons.add, size: 20),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Task")
                .where("status", isEqualTo: "Pending")
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
                    trailing: Text("Assign...")
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
