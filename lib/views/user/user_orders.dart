import 'package:flutter/material.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Orders"),
      ),
    );
  }
}
