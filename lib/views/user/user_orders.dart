import 'package:ar_hardware/models/checkout_model.dart';
import 'package:ar_hardware/viewModel/product_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/checkout_card.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  final ProductViewModel _productViewModel = Get.put(ProductViewModel());

  @override
  void initState() {
    super.initState();
    _productViewModel.fetchCheckoutProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<List<CheckoutModel>>(
              stream: _productViewModel.checkoutStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  List<CheckoutModel>? checkout = snapshot.data;
                  if (checkout != null && checkout.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: checkout.length,
                        itemBuilder: (context, index) =>
                            CheckoutCard(checkoutModel: checkout[index]),
                      ),
                    );
                  } else {
                    return const Center(
                      child: AutoSizeText(
                        'No product purchased!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
