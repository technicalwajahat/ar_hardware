import 'package:ar_hardware/viewModel/auth_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final authViewModel = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    // Full Name Field
    final fullNameField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: authViewModel.fullName,
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        authViewModel.fullName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Username Field
    final userNameField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: authViewModel.username,
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(40),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return ("Username cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        authViewModel.username.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Email Field
    final emailField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: authViewModel.registerEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        authViewModel.registerEmail.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Mobile Number Field
    final mobileNoField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: authViewModel.phone,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      onSaved: (value) {
        authViewModel.phone.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your mobile number");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mobile Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Password Field
    final passwordField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: authViewModel.registerPassword,
      obscureText: authViewModel.isObscure.value,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 8 Character)");
        }
        return null;
      },
      onSaved: (value) {
        authViewModel.registerPassword.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(authViewModel.isObscure.value
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: authViewModel.checkObscurePassword,
        ),
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Confirm Password Field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      validator: (value) {
        if (authViewModel.confirmPassword.text !=
            authViewModel.registerPassword.text) {
          return "Password don't match";
        }
        return null;
      },
      controller: authViewModel.confirmPassword,
      obscureText: authViewModel.isObscure2.value,
      onSaved: (value) {
        authViewModel.confirmPassword.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(authViewModel.isObscure2.value
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: authViewModel.checkObscureConfirmPassword,
        ),
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Role Field
    final roleField = DropdownButtonFormField<String>(
      autofocus: false,
      value: authViewModel.dropdownValue.value,
      isExpanded: true,
      onChanged: authViewModel.onChanged,
      items: <String>['User', 'Vendor']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: AutoSizeText(value),
        );
      }).toList(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        hintText: "Role",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Register Button
    final registerButton = FilledButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_formKey.currentState!.validate()) {
          final user = UserModel(
            email: authViewModel.registerEmail.text.trim(),
            username: authViewModel.username.text.trim(),
            name: authViewModel.fullName.text.trim(),
            phone: authViewModel.phone.text.trim(),
            password: authViewModel.registerPassword.text.trim(),
            role: authViewModel.dropdownValue.value.trim(),
          );
          authViewModel.registerUser(context, user);
        }
      },
      child: const AutoSizeText(
        "Register",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 28, left: 28, right: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const AutoSizeText(
                      "Lets Get Started!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.001),
                    const AutoSizeText(
                      "Create an account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    fullNameField,
                    SizedBox(height: Get.height * 0.025),
                    userNameField,
                    SizedBox(height: Get.height * 0.025),
                    emailField,
                    SizedBox(height: Get.height * 0.025),
                    mobileNoField,
                    SizedBox(height: Get.height * 0.025),
                    roleField,
                    SizedBox(height: Get.height * 0.025),
                    passwordField,
                    SizedBox(height: Get.height * 0.025),
                    confirmPasswordField,
                    SizedBox(height: Get.height * 0.03),
                    registerButton,
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const AutoSizeText(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed("/login");
                          },
                          child: const AutoSizeText(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
