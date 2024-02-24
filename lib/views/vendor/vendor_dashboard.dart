import 'package:ar_hardware/widgets/appBar.dart';
import 'package:flutter/material.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(text: 'Vendor'),
      body: SafeArea(
        child: Center(
          child: Text("Vendor Dashboard"),
        ),
      ),
    );
  }
}
