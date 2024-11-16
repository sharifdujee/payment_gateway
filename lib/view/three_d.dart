import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ThreeDScreen extends StatefulWidget {
  const ThreeDScreen({super.key});

  @override
  State<ThreeDScreen> createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 3D'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Hello Md Robayet Bin Rahat'),
            SizedBox(
              height: 400,
                child: Flutter3DViewer(src: 'assets/3d/DamagedHelmet.glb'))
          ],
        ),
      ),
    );
  }
}
