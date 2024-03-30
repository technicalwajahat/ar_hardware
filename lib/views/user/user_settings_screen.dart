import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/auth_repository.dart';
import '../../widgets/settigs_card_widget.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({super.key});

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingCard(
              title: "Change Password",
              leading: Icons.password,
              onTap: () {
                Get.toNamed('/forgetPassword');
              },
            ),
            SizedBox(height: Get.height * 0.005),
            SettingCard(
              title: "Logout",
              leading: Icons.logout_rounded,
              onTap: () {
                AuthRepository.instance.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
