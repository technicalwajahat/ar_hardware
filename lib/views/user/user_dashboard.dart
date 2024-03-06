import 'package:flutter/material.dart';

import '../../repository/auth_repository.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User",
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
