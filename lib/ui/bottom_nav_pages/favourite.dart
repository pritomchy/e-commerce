import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<String> _productImages = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProductImages() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _productImages.add(
          qn.docs[i]["product-img"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProductImages();

    super.initState();
  }
  bool flage = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.pink,
          title: Text("Your Favourite Item")),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-favourite-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

            }

            return Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Text(
                              _documentSnapshot['name'],
                            ),
                            title: Text(
                              "\$ ${_documentSnapshot['price']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            trailing: GestureDetector(
                              child: CircleAvatar(
                                child: Icon(Icons.remove_circle),
                              ),


                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("users-favourite-items")
                                    .doc(FirebaseAuth
                                    .instance.currentUser!.email)
                                    .collection("items")
                                    .doc(_documentSnapshot.id)
                                    .delete();

                              },
                            ),
                          ),
                        );
                      }),
                ),


              ],
            );
          },
        ),
      ),

    );
  }
}
