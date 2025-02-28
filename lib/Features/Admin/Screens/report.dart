import 'package:disaster_management/Model/NotificationModel.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/material.dart';

class ShowReport extends StatefulWidget {
  final  NotificationModel model;

  const ShowReport({super.key, required this.model});
  @override
  State<ShowReport> createState() => _ShowReportState();
}

class _ShowReportState extends State<ShowReport> {


  // final List<String> imageUrls =

  // [
  //   'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0', // Nature
  //   'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8', // City
  //   'https://images.unsplash.com/photo-1546182990-dffeafbe841d', // Animals
  //   'https://images.unsplash.com/photo-1518770660439-4636190af475', // Technology
  //   'https://images.unsplash.com/photo-1522202176988-66273c2fd55f', // People
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Report'),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.model.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
            "${widget.model.description}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text("${widget.model.location}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // ✅ Wrap ListView inside a Column
            Column(
              children: List.generate(widget.model.imagePaths.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Image.network(
                          widget.model.imagePaths[index],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        SizedBox(height: 10),
                        Text(
                          'Image ${index + 1}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
