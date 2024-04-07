import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../models/product_model.dart';

class UserProductCard extends StatelessWidget {
  final ProductModel product;

  const UserProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/viewDetail", arguments: [product]);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 14),
        elevation: 3,
        child: Row(
          children: [
            SizedBox(
              width: 140,
              height: 140,
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
            SizedBox(width: Get.width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  product.productName.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
                PersistentShoppingCart().showAndUpdateCartItemWidget(
                  inCartWidget: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: AutoSizeText(
                          'Remove',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  notInCartWidget: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: AutoSizeText(
                          'Add to Cart',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  product: PersistentShoppingCartItem(
                    productId: product.id.toString(),
                    productName: product.productName.toString(),
                    unitPrice: double.parse(product.productPrice.toString()),
                    quantity: 1,
                    productDescription: product.productMaterial,
                    productThumbnail: product.productImage,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
