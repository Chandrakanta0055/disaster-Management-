import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/NotificationModel.dart';
import '../../../provider/user_provider.dart';
import 'CommonServices.dart';


class ComplainServices {
  Future<void> giveComplain({
    required BuildContext context,
    required String title,
    required String description,
    required List<File> images,
    required String location,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (user == null) {
      ShowSnakbar('User not authenticated',context);
      return;
    }

    try {
      CommonServices service = CommonServices();
      List<String> imageUrl = await service.uploadImages(
        context: context,
        images: images,
      );

      String id = DateTime.now().millisecondsSinceEpoch.toString();
      NotificationModel model = NotificationModel(
        id: id,
        title: title,
        description: description,
        imagePaths: imageUrl,
        location: location,

        dateSubmitted: Timestamp.now().toString(), // Using Timestamp.now()
        senderId: user.uid,
        category: "ComplainBox",
      );

      await FirebaseFirestore.instance
          .collection("Notification")
          .doc(id)
          .set(model.toMap());

      ShowSnakbar("Report Submitted",context);
    } catch (e) {
      ShowSnakbar( e.toString(),context);
    }
  }
}
