import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ecommerce_app/ui/bottom_nav_controller.dart';
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
              Notify();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavController()));
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
        title: 'Bazar.com',
        body: 'your Order is Complete',

      ),
    schedule: NotificationInterval(interval: 3, timeZone: timezom,repeats: false),
  );
}