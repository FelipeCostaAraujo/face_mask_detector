import 'package:camera/camera.dart';
import 'package:facemask_app/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = "";

  void initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((image) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = image;
            runModelOnFrame();
          }
        });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  runModelOnFrame() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: imgCamera.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: imgCamera.height,
          imageWidth: imgCamera.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true);

      result = "";

      recognitions.forEach((response) {
        result += response["label"] + "\n";
      });

      setState(() {});

      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          result,
          style: TextStyle(
              backgroundColor: Colors.black54,
              fontSize: 30,
              color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height * 0.7,
              child: Container(
                child: !cameraController.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
              )),
        ],
      ),
    );
  }
}
