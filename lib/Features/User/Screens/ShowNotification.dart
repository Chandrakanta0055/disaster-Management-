import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Model/NotificationModel.dart';
import '../../Admin/Screens/report.dart';

class ShowNotification extends StatefulWidget {
  const ShowNotification({Key? key}) : super(key: key);

  @override
  _ShowNotificationState createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Notifications'),
        ),
        body: const Center(
          child: Text('User not logged in'),
        ),
      );
    }

    final Stream<QuerySnapshot> notificationsStream = FirebaseFirestore.instance
        .collection('Notification')
        .where('senderId', isEqualTo: user.uid)
        .orderBy('dateSubmitted', descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notificationsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          final notifications = snapshot.data!.docs.map((doc) {
            return NotificationModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];

              return ListTile(
                onTap: (){
                  if(notification.category == "ComplainBox"){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowReport(model:notification)));

                  }
                },
                title: Text(notification.title),
                subtitle: Text(notification.description),
                trailing: Text(
                  notification.dateSubmitted.toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
