
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/edit_profile.dart';
import 'package:ecommerce_app/ui/bottom_nav_controller.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  updateUserDetail() {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-form-data");
    var CustomToast;
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController.text,
      "phone": _phoneController.text,
      "address": _addressController.text,
    }).then((value) => CustomToast.toast('Updated Successfully'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 25,
            color: Colors.black,
          ),
          onPressed: () {
            {Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavController()));}
          },
        ),
        title: Text(
          'User Profile Update',
          style: TextStyle(

              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                        //profile Pic
                        child: Column(
                          children: [
                            Stack(fit: StackFit.loose, children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/pritom.JPG'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding:
                                  EdgeInsets.only(top: 90.0, right: 100.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25.0,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    //Edit
                                  ],
                                )),
                            LabelForProfile(labelForProfile: '🧑‍ Name'),
                            InputFieldForProfile(
                              qTextEditController: _nameController =
                                  TextEditingController(text: data['name']),
                              isEnable: true,
                              hintTextForInputField: "Enter Your Name",
                            ),
                            //Email Address
                            //Mobile Number
                            LabelForProfile(
                                labelForProfile: '📱 Mobile Number'),
                            InputFieldForProfile(
                              qTextEditController: _phoneController =
                                  TextEditingController(text: data['phone']),
                              isEnable: true,
                              hintTextForInputField: "Enter Mobile Number",
                            ),
                            LabelForProfile(
                                labelForProfile: '🗼 Contract Address'),
                            InputFieldForProfile(
                              qTextEditController: _addressController =
                                  TextEditingController(text: data['address']),
                              isEnable: true,
                              hintTextForInputField: "Enter Contract Address",
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 45.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child:MaterialButton(
                                              color: Colors.green,
                                              elevation: 0,
                                              height: 50,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(10)),
                                              onPressed: () { updateUserDetail(); },
                                              child: Text(
                                                'Update',
                                                style: TextStyle(color: Colors.white,
                                                    fontWeight: FontWeight.w600, fontSize: 18),
                                              ),
                                            )
                                        ),



                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child:MaterialButton(
                                              color: Colors.red,
                                              elevation: 0,
                                              height: 50,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(10)),
                                              onPressed: () { Navigator.pop(context); },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(color: Colors.white,
                                                    fontWeight: FontWeight.w600, fontSize: 18),
                                              ),
                                            )
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}




class InputFieldForProfile extends StatelessWidget {
  final String hintTextForInputField;
  final bool isEnable;
  final TextEditingController qTextEditController;

  InputFieldForProfile(
      {required this.hintTextForInputField, required this.isEnable, required this.qTextEditController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: qTextEditController,
              decoration: InputDecoration(hintText: hintTextForInputField),
              enabled: isEnable,
            ),
          ),
        ],
      ),
    );
  }
}
class LabelForProfile extends StatelessWidget {
  final String labelForProfile;

  LabelForProfile({required this.labelForProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                labelForProfile,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   TextEditingController ?_nameController;
//   TextEditingController ?_phoneController;
//   TextEditingController ?_addressController;
//
//
//   setDataToTextField(data){
//     return  Column(
//       children: [
//         TextFormField(
//           controller: _nameController = TextEditingController(text: data['name']),
//         ),
//         TextFormField(
//           controller: _phoneController = TextEditingController(text: data['phone']),
//         ),
//       TextFormField(
//         controller: _addressController= TextEditingController(text: data['address']),
//
//       ),
//         SizedBox(
//           height: 20,
//         ),
//         Column(
//           children: [
//             ElevatedButton(onPressed: () => updateData(), child: Text("Done")),
//           ],
//         ),
//
//       ],
//     );
//   }
//
//   updateData(){
//     CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
//     return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
//         {
//           "name":_nameController!.text,
//           "phone":_phoneController!.text,
//
//           "address":_addressController!.text,
//         }
//     ).then((value) => print("Updated Successfully"));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.green,
//           ),
//           onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavController()));},
//         ),
//         title: Text(
//           "Cash On Delivery System",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 4.0,
//         actions: [
//
//           IconButton(
//             icon: Icon(
//               Icons.person,
//               size: 25,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => EditProfilePage()),
//               );
//             },
//           ),
//         ],
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: SafeArea(child: Padding(
//         padding: const EdgeInsets.all(20.0),
//
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
//           builder: (BuildContext context, AsyncSnapshot snapshot){
//             var data = snapshot.data;
//
//             if(data==null){
//               return Center(child: CircularProgressIndicator(),);
//             }
//             return setDataToTextField(data);
//           },
//
//         ),
//       )),
//     );
//   }
// }
