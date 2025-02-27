import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommonServices {
  Future<List<String>> uploadImages({
    required BuildContext context,
    required List<File> images,
  }) async {
    List<String> downloadUrls = [];
    try {
      for (File image in images) {
        // Create a unique file name for each image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        // Create a reference to the Firebase Storage bucket
        Reference ref = FirebaseStorage.instance.ref().child('disaster/$fileName');
        // Upload the file to Firebase Storage
        UploadTask uploadTask = ref.putFile(image);
        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask;
        // Get the download URL
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        downloadUrls.add(downloadUrl);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images: $e')),
      );
    }
    print("function end");
    return downloadUrls;
  }
}
