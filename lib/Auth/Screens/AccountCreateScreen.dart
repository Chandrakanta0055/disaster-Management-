import 'package:disaster_management/Auth/services/account_create.dart';
import 'package:disaster_management/constants/CustomButton.dart';
import 'package:disaster_management/constants/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AccountCreateScreen extends StatefulWidget {
  final String email;
  final String Password;
  const AccountCreateScreen({super.key, required this.email, required this.Password});

  @override
  State<AccountCreateScreen> createState() => _AccountCreateScreenState();
}

class _AccountCreateScreenState extends State<AccountCreateScreen> {
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();

  void clickNextButton()async{
    if(nameController.text.isEmpty || phoneNoController.text.isEmpty || addressController.text.isEmpty){
      ShowSnakbar("pleased Enter all the detail", context);
      return;
    }
    AccountCreateServices services = AccountCreateServices();
    services.CreateAccount(context: context, email: widget.email, phone: phoneNoController.text, name: nameController.text, address: addressController.text,password: widget.Password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemYellow,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text("GOVERNMENT OF  INDIA", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35) ,),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),

                  )
                  
                ),
                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(

                      color: Colors.black
                  ),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2)
                    )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: phoneNoController,
                        decoration: InputDecoration(
                            hintText: "Phone No",
                            hintStyle: TextStyle(
                                color: Colors.black
                            ),
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white, width: 2)
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: TextStyle(
                                color: Colors.black
                            ),
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white, width: 2)
                            )
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: 100,
                        child: CustomButton(
                          bgColor: CupertinoColors.systemYellow,
                            text: "Next", callback: clickNextButton),
                      )
                    ],
                  ),
                ),
              ),
            )

          ],

        ),
      ),
    );
  }
}
