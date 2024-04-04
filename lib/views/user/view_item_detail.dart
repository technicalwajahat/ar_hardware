import 'package:ar_hardware/widgets/appBar.dart';
import 'package:flutter/material.dart';

class ViewItemDetail extends StatefulWidget {
  const ViewItemDetail({super.key});

  @override
  State<ViewItemDetail> createState() => _ViewItemDetailState();
}

class _ViewItemDetailState extends State<ViewItemDetail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(text: "Product Detail"),
      body: Center(),
    );
  }
}
