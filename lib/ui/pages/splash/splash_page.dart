import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:facemask_app/ui/pages/pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomePage(),
      title: Text("Face Mask Detector App"),
      styleTextUnderTheLoader: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueAccent),
      image: Image.asset("assets/images/splash.png"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        "From coding Cafe",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
