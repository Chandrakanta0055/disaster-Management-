import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/Features/User/widgets/showFeedBack.dart';
import 'package:disaster_management/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
    final userData = Provider.of<UserProvider>(context,listen: false).user;

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

    final Stream<QuerySnapshot> AdminnotificationsStream = FirebaseFirestore.instance
        .collection('Notification')
        .orderBy('dateSubmitted', descending: true)
        .snapshots();


    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: userData!.role == "admin" ? AdminnotificationsStream : notificationsStream,
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

                return notification.category == "FeedBack"?
                    ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Showfeedback(model: notification)));

                      },
                      title: Text("${notification.name}"),
                      subtitle:
                      Container(
                        
                        child: RatingBar.builder(
                          initialRating: notification!.rating!,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 5,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                            });
                          },
                        ),
                      ),
                    )

                    : ListTile(
                  onTap: (){
                    if(notification.category == "ComplainBox"){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowReport(model:notification)));
                    }
                  },
                  title: Row(
                    children: [
                      Expanded(child: Text(notification.title),
                      ),
                      Container(child: Text(notification.dateSubmitted.toString(),style: TextStyle(fontSize: 10),))
                    ],
                  ),
                  subtitle: Text(notification.description),
                  // trailing: (
                  //   child: Text(
                  //     notification.dateSubmitted.toString(),
                  //   ),
                  // ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
