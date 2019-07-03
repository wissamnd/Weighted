import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body:new Container(
        padding: EdgeInsets.all(50.0),
        child: new Center(
          child:Image.asset(
            "assets/Weight.png",
            width: 150,
            height: 150,),
        ),
      )
      
    );
  }
}