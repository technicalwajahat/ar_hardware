import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../viewModel/product_viewmodel.dart';

class VendorProductCard extends StatelessWidget {
  final ProductModel product;

  final _productViewModel = Get.put(ProductViewModel());

  VendorProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 115,
            height: 115,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(10)),
              child: Image.network(
                product.productImage.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                product.productName.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: Get.height * 0.008),
              AutoSizeText(
                "Price: ${product.productPrice}\$",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: Get.height * 0.003),
              AutoSizeText(
                "Stock: ${product.productStock}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: Get.height * 0.003),
              AutoSizeText(
                "Material: ${product.productMaterial}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.zero,
                child: IconButton(
                  onPressed: () {
                    Get.toNamed("/editProduct", arguments: {"product": product})
                        ?.then((value) => _productViewModel.fetchProducts());
                  },
                  icon: const Icon(Icons.edit, color: Colors.green),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                child: IconButton(
                  onPressed: () {
                    _productViewModel
                        .deleteProduct(product.id.toString())
                        .then((value) => _productViewModel.fetchProducts());
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
