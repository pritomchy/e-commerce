
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_nav_controller.dart';


class CheckOut
    extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _ageController = TextEditingController();


  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );

  }

  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("check-out-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "address":_addressController.text,

      "age":_ageController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()))).catchError((error)=>print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Check out process.",
                  style:
                  TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "enter your name"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration:
                  InputDecoration(hintText: "enter your phone number"),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "enter your current adress"),
                ),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: InputDecoration(hintText: "enter your age"),
                ),
                SizedBox(
                  height: 50.h,
                ),
                // elevated button
                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          sendUserDataToDB();
                        },
                        child: Text(
                          "Process",
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.deep_orange,
                          elevation: 3,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          var route =
                          Notify();
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.deep_orange,
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocalNotify extends StatefulWidget{
  @override
  _LocalNotifyState createState() => _LocalNotifyState();
}
class _LocalNotifyState extends State<LocalNotify>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Icon(Icons.call),

        ),
      ),
    );
  }
}
void Notify() async{
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Checkout Process Done',
        body: 'your Shopping Is complete',

      ),
    schedule: NotificationInterval(interval: 5, timeZone: timezom,repeats: false),
  );
}