
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/ui/checkout_process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int price=0;
  bool flage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.pink,
          title: Text("Your Cart")
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-cart-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {

              var data = snapshot.data;
              if(!flage){
                int localPrice = 0;
                data!.docs.forEach((element) {
                  print(int.tryParse(element["price"].toString()).runtimeType);
                  price = price + int.parse(element["price"].toString());

                });
                flage = true;
              };

            }

            return Column(
              children: [
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data==null?0:snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading:

                               Text(_documentSnapshot['name'],),

                            title: Text(
                              "\$ ${_documentSnapshot['price']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            trailing: GestureDetector(
                              child: CircleAvatar(
                                child: Icon(Icons.remove_circle),
                              ),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("users-cart-items")
                                    .doc(FirebaseAuth.instance.currentUser!.email)
                                    .collection("items")
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),

                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Price: ${price}",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0
                  ),),
                ),
                RaisedButton(
                  onPressed: (){  Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));},
                  color: Colors.cyan,
                  padding: EdgeInsets.symmetric(vertical:15.0,horizontal: 25.0),
                  child: Text(
                    "Buy Now", style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                  ),
                ),

              ],

            );

          },
        ),
      ),
    );
  }
}

