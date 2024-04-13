import 'package:ar_hardware/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaintWallScreen extends StatefulWidget {
  const PaintWallScreen({super.key});

  @override
  State<PaintWallScreen> createState() => _PaintWallScreenState();
}

class _PaintWallScreenState extends State<PaintWallScreen> {
  var result = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Painted Wall'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Image.memory(
            result,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
