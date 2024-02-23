import 'package:ar_hardware/viewModel/auth_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appBar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authViewModel = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    // Email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: _authViewModel.forgetEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        _authViewModel.forgetEmail.text = value!.trim();
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Forget Password
    final forgetButton = FilledButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_formKey.currentState!.validate()) {
          _authViewModel.changePassword(
              _authViewModel.forgetEmail.text.trim(), context);
        }
      },
      child: const AutoSizeText(
        "Reset Password",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

    return Scaffold(
      appBar: const AppBarWidget(text: "Change Password"),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 28, left: 28, right: 28),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  emailField,
                  SizedBox(height: Get.height * 0.03),
                  forgetButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
