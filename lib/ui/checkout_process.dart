
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/provider.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ui/confirmation_screen.dart';
class Checkout extends StatefulWidget {
  Checkout({required this.price});
  int price;
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  // Payment selectePayment;

  Color activeColor = Colors.pink;
  Color disableColor = Colors.grey;

  Future<void> deleteProductsOnCart()async{
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    return _fireStore.collection('users-form-data')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('users-form-data')
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Total>(context);

    return Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.pink,
          title: Center(child: Text("Checkout"))),


      body:
      Column(
        children: [
          Expanded(
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 260,
                    ),
                    Text(
                      'Order Detail',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal',style: TextStyle(color: Colors.black38),),
                          Text('\$' + widget.price.toString(),style: TextStyle(color: Colors.black38),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping Cost',style: TextStyle(color: Colors.black38),),
                          Text('+\$10.0',style: TextStyle(color: Colors.black38),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',style: TextStyle(color: Colors.black38),),
                          Text('\$' + (widget.price+10.0).toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18.0),),
                        ],
                      ),
                    ),

                  ],
                ),
              )),
          SizedBox(height: 20.0,),

          Card(
            child: Column(
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [

                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));}
                          },

                          child: Text('Cash On Delivery'),
                        ),
                      )
                    ],
                  ),
                )
              ],

            ),
          ),
        ],

      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: MaterialButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'CHECKOOUT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    content: Text('confirm your order?'),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text(
                                'NO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.pink,
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {

                                setState(() {
                                  providerData.ResetTotal();
                                  deleteProductsOnCart();
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Confirm()));
                              },
                              child: Text(
                                'YES',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "CHECKOUT (\$" + (widget.price+10.0).toString() + ")",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.pink,
        ),
      ),
    );
  }
}







