import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_repository.dart';
import '../utils/utils.dart';

class AuthViewModel extends GetxController {
  static AuthViewModel get instance => Get.find();

  // TextFields Controller
  final loginEmail = TextEditingController();
  final registerEmail = TextEditingController();
  final forgetEmail = TextEditingController();
  final registerPassword = TextEditingController();
  final loginPassword = TextEditingController();
  final fullName = TextEditingController();
  final username = TextEditingController();
  final phone = TextEditingController();
  final confirmPassword = TextEditingController();

  final UserRepository _userRepo = Get.put(UserRepository());
  final AuthRepository _authRepo = Get.put(AuthRepository());

  var dropdownValue = 'User'.obs;
  RxBool isObscure = true.obs;
  RxBool isObscure2 = true.obs;

  // Login User ViewModel
  void loginUser(String email, String password, BuildContext context) {
    _authRepo.loginWithEmailAndPassword(email, password, context).then((_) {
      Utils.snackBar("Login Successfully!", context);
    });
  }

  // Register User ViewModel
  void registerUser(BuildContext context, UserModel user) {
    _authRepo
        .createUserWithEmailAndPassword(user.email!, user.password!, context)
        .then((_) {
      user.id = _authRepo.firebaseUser.value!.uid;
      _userRepo.createUser(user);
      Utils.snackBar("Success, Your account has been created.", context);
    });
  }

  // Get User Data ViewModel
  Future<UserModel> getUserData() {
    final email = _authRepo.firebaseUser.value!.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
      return Future.error("Login Required");
    }
  }

  // Change Password ViewModel
  void changePassword(String email, BuildContext context) {
    _authRepo.changePasswordWithEmail(email).then((_) {
      Utils.snackBar("Email Sent!", context);
    });
  }

  void checkObscurePassword() {
    isObscure.value = !isObscure.value;
  }

  void checkObscureConfirmPassword() {
    isObscure2.value = !isObscure2.value;
  }

  void onChanged(String? value) {
    if (value != null) {
      dropdownValue.value = value;
    }
  }
}
