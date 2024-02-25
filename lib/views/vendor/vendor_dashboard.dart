import 'package:flutter/material.dart';

import '../../repository/auth_repository.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vendor",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FilledButton(
            onPressed: () {
              AuthRepository.instance.logout();
            },
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}
