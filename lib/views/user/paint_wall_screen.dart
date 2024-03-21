import 'package:ar_hardware/widgets/appBar.dart';
import 'package:flutter/material.dart';

class PaintWallScreen extends StatefulWidget {
  const PaintWallScreen({super.key});

  @override
  State<PaintWallScreen> createState() => _PaintWallScreenState();
}

class _PaintWallScreenState extends State<PaintWallScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(text: 'Painted Wall'),
    );
  }
}
