import 'package:ecommerce_app/ui/bottom_nav_pages/home.dart';
import 'package:ecommerce_app/ui/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Confirm
    extends StatefulWidget {

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 100.0,),
              Image.asset('assets/images/cong.jpg', height:200.0),
              Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Order Successfully',
                          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Set',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45, right: 45, top: 20),
                        child: Text(
                          'Your request for all items has been effectively positioned and has been handled for conveyance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SplashScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Keep Shopping",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
              ),
            ),
            color: Colors.brown,

          ),
        ),
      ),
    );
  }
}
