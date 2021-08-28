import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/provider.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ui/confirmation_screen.dart';

// enum  Payment { bKash, cashOnDelivery }

class Checkout extends StatefulWidget {
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
          title: Text("Checkout")),
      body: Column(
        children: [
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
                            // setState(() {
                            //   selectePayment = Payment.bKash;
                            // });
                          },
                          // color: selectePayment == Payment.bKash
                          //     ? activeColor
                          //     : disableColor,
                          child: Text('bKash (017********)'),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            // setState(() {
                            //   selectePayment = Payment.cashOnDelivery;
                            // });
                          },
                          // color: selectePayment == Payment.cashOnDelivery
                          //     ? activeColor
                          //     : disableColor,
                          child: Text('Cash On Delivery'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Expanded(
              child: Card(
                child: Column(
                  children: [
                    Text(
                      'Order Info',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal',style: TextStyle(color: Colors.black38),),
                          Text('\$' + providerData.tot.toString(),style: TextStyle(color: Colors.black38),),
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
                          Text('\$' + (providerData.tot+10.0).toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18.0),),
                        ],
                      ),
                    ),

                  ],
                ),
              )),
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
                    content: Text('Do you want to confirm your order?'),
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
              "CHECKOUT (\$" + (providerData.tot+10).toString() + ")",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.pink,
        ),
      ),
    );
  }
}







// class LocalNotify extends StatefulWidget{
//   @override
//   _LocalNotifyState createState() => _LocalNotifyState();
// }
// class _LocalNotifyState extends State<LocalNotify>{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//
//           },
//           child: Icon(Icons.call),
//
//         ),
//       ),
//     );
//   }
// }
// void Notify() async{
//   String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1,
//         channelKey: 'key1',
//         title: 'Checkout Process Done',
//         body: 'your Shopping Is complete',
//
//       ),
//     schedule: NotificationInterval(interval: 5, timeZone: timezom,repeats: false),
//   );
// }