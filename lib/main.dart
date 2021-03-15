import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

import 'package:facemask_app/ui/pages/pages.dart';

List<CameraDescription> cameras;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mask Detector',
      debugShowCheckedModeBanner: false,
      home: SplashPage()
    );
  }
}