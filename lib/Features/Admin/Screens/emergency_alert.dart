import 'dart:io';

import 'package:disaster_management/Features/User/Srevices/complainServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/CustomButton.dart';
import '../../../constants/globalVariables.dart';

class EmergencyAlert extends StatefulWidget {
  const EmergencyAlert({super.key});

  @override
  State<EmergencyAlert> createState() => _EmergencyAlertState();
}

class _EmergencyAlertState extends State<EmergencyAlert> {
  TextEditingController titleController = TextEditingController();
  String description = "";
  List<File> _images = [];
  final picker = ImagePicker();

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
    }
  }
  void GiveComplain()async{
    if(titleController.text.isEmpty || description == "")
    {
      ShowSnakbar("pleased Enter title and Description", context);
      return;
    }
    ComplainServices services = ComplainServices();
    services.giveComplain(context: context, title: titleController.text.trim(), description: description, images: _images, location: "");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Alert"),
        backgroundColor: appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black12
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black12
                  ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  decoration: InputDecoration.collapsed(hintText: "Enter Description"),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child:
                      CustomButton(text: "Attach Images", callback: _pickImages)
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child:
                      CustomButton(text: " Location", callback: (){

                      })
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (_images.isNotEmpty)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _images.asMap().entries.map((entry) {
                    int index = entry.key;
                    File image = entry.value;
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(
                          image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                ),

              SizedBox(height: 20,),
              Container(width: 300,
                child: CustomButton(text: "Submit", callback: GiveComplain),
              )
            ],
          ),
        ),
      ),
    );
  }
}
