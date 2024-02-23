import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Create User
  createUser(UserModel userModel, BuildContext context) {
    _db.collection("users").add(userModel.toJson());
  }

  // Get Single User Detail
  Future<UserModel> getUserDetails(String? email) async {
    final snapshot =
        await _db.collection("users").where('email', isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // Dashboard Navigation
  void navigationDashboard(String uid) async {
    await _db.collection("users").doc(uid).get().then((value) {
      final role = value.data()?['role'].toString();
      if (role == 'User') {
        Get.offAllNamed('/userDashboard');
      } else {
        Get.offAllNamed('/vendorDashboard');
      }
    });
  }
}
