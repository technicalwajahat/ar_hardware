import 'package:ar_hardware/views/user/user_dashboard.dart';
import 'package:ar_hardware/views/vendor/vendor_dashboard.dart';
import 'package:get/get.dart';

import '../views/auth/forget_password_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/register',
        page: () => const RegisterScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/forgetPassword',
        page: () => const ForgetPasswordScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/userDashboard',
        page: () => const UserDashboard(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/vendorDashboard',
        page: () => const VendorDashboard(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
