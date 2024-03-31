import 'package:ar_hardware/models/checkout_model.dart';
import 'package:ar_hardware/widgets/appBar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

import '../../payment_config.dart';
import '../../repository/auth_repository.dart';
import '../../viewModel/product_viewmodel.dart';

enum Payment { cash, online }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Rx<Payment> payment = Payment.cash.obs;
  var arguments = Get.arguments;
  final authRepo = Get.put(AuthRepository());
  ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    final paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: arguments['totalPrice'].toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      appBar: const AppBarWidget(text: 'Checkout'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Obx(
              () {
                return Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Cash',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      leading: Radio<Payment>(
                        value: Payment.cash,
                        groupValue: payment.value,
                        onChanged: (Payment? value) {
                          payment.value = value!;
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Online Payment',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      leading: Radio<Payment>(
                        value: Payment.online,
                        groupValue: payment.value,
                        onChanged: (Payment? value) {
                          payment.value = value!;
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    payment.value == Payment.cash
                        ? FilledButton(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              final checkout = CheckoutModel(
                                userId: authRepo.firebaseUser.value!.uid,
                                totalAmount: arguments['totalPrice'].toString(),
                                totalItems: arguments['quantity'].toString(),
                                dateToday: Timestamp.now(),
                              );
                              productViewModel.checkoutProduct(checkout,
                                  context, arguments['productDetail']);
                            },
                            child: const AutoSizeText(
                              "Pay via Cash",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : GooglePayButton(
                            paymentConfiguration:
                                PaymentConfiguration.fromJsonString(
                                    defaultGooglePay),
                            width: double.infinity,
                            paymentItems: paymentItems,
                            type: GooglePayButtonType.pay,
                            onPaymentResult: (result) {},
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
