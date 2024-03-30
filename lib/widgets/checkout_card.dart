import 'package:ar_hardware/models/checkout_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutCard extends StatefulWidget {
  final CheckoutModel checkoutModel;

  const CheckoutCard({super.key, required this.checkoutModel});

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Purchased Items: ${widget.checkoutModel.totalItems}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Get.height * 0.008),
                AutoSizeText(
                  dateFormatter(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.005),
            AutoSizeText(
              "\$${widget.checkoutModel.totalAmount}",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  String dateFormatter() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().format(now);
    return formattedDate;
  }
}
