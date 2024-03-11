import 'package:ar_hardware/views/user/user_dashboard.dart';
import 'package:ar_hardware/views/vendor/add_product.dart';
import 'package:ar_hardware/views/vendor/edit_product.dart';
import 'package:ar_hardware/views/vendor/vendor_dashboard.dart';
import 'package:get/get.dart';

import '../views/auth/forget_password_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../widgets/loading_widget.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/register',
        page: () => const RegisterScreen(),
      ),
      GetPage(
        name: '/forgetPassword',
        page: () => const ForgetPasswordScreen(),
      ),
      GetPage(
        name: '/userDashboard',
        page: () => const UserDashboard(),
      ),
      GetPage(
        name: '/vendorDashboard',
        page: () => const VendorDashboard(),
      ),
      GetPage(
        name: '/loading',
        page: () => const LoadingScreen(),
      ),
      GetPage(
        name: '/addProduct',
        page: () => const AddProductScreen(),
      ),
      GetPage(
        name: '/editProduct',
        page: () => const EditProductScreen(),
      ),
    ];
