import 'package:ar_hardware/views/user/user_home_screen.dart';
import 'package:ar_hardware/views/user/user_orders.dart';
import 'package:ar_hardware/views/user/user_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../../viewModel/dashboard_viewmodel.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final _dashboardViewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "AR Hardware Haven",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Get.toNamed('/myCart');
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: _dashboardViewModel.selectedIndex.value,
          children: const [UserHomeScreen(), UserOrders(), UserSettingScreen()],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: _dashboardViewModel.changeIndex,
          selectedIndex: _dashboardViewModel.selectedIndex.value,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_bag_rounded),
              icon: Icon(Icons.shopping_bag_rounded),
              label: 'Orders',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   tooltip: "Camera",
      //   onPressed: () {
      //     Get.toNamed('/takePicture');
      //   },
      //   child: const Icon(
      //     Icons.camera,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
