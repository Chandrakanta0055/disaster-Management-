import 'package:disaster_management/Model/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Showfeedback extends StatelessWidget {
  final NotificationModel model ;
  const Showfeedback({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10,),
            RatingBar.builder(
              initialRating: model!.rating!,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 2,
              ),
              onRatingUpdate: (rating) {
              },
            ),
            SizedBox(height: 20,),
            Text("Description:"),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(model.description),
            )


          ],
        ),
      ),
    );
  }
}
