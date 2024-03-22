import 'package:ar_hardware/widgets/appBar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Payment { cash, online }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Rx<Payment> payment = Payment.cash.obs;

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () {},
                            child: const AutoSizeText(
                              "Pay via Cash",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : Container()
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
