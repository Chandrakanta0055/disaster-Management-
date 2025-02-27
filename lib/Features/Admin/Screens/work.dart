import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/material.dart';

class Work extends StatefulWidget {
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<Work> {
  final List<Map<String, String>> tasks = [
    {'title': 'Task 1', 'location': 'Location A'},
    {'title': 'Task 2', 'location': 'Location B'},
    {'title': 'Task 3', 'location': 'Location C'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        backgroundColor: BGColor,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(tasks[index]['title']!),
              subtitle: Text(tasks[index]['location']!),
              trailing: ElevatedButton(
                onPressed: () {
                  // Implement task assignment logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Assigned: ${tasks[index]['title']}')),
                  );
                },
                child: Text('Assign Task'),
              ),
            ),
          );
        },
      ),
    );
  }
}