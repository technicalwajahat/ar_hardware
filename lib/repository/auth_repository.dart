import 'package:ar_hardware/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../exceptions/auth_exceptions.dart';
import '../utils/utils.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _userRepo = Get.put(UserRepository());
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAllNamed("/login") : navigateToDashboard(user.uid);
  }

  // Register User Email & Password
  Future<void> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Utils.snackBar(ex.message, context);
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      Utils.snackBar(ex.message, context);
      throw ex;
    }
  }

  // Login Email & Password
  Future<void> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithEmailAndPasswordFailure.code(e.code);
      Utils.snackBar(ex.message, context);
      throw ex;
    } catch (_) {
      const ex = SignInWithEmailAndPasswordFailure();
      Utils.snackBar(ex.message, context);
    }
  }

  // Change Password
  Future<void> changePasswordWithEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (_) {}
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  navigateToDashboard(String uid) {
    _userRepo.navigationDashboard(uid);
  }
}
