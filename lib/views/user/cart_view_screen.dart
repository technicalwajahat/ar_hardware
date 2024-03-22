import 'package:ar_hardware/widgets/appBar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartViewScreen extends StatefulWidget {
  const CartViewScreen({super.key});

  @override
  State<CartViewScreen> createState() => _CartViewScreenState();
}

class _CartViewScreenState extends State<CartViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: "My Cart"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) => Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(10),
                            ),
                            child: Image.network(
                              data.productThumbnail.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.06),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              data.productName.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.008),
                            AutoSizeText(
                              "Stock: ${data.quantity}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.003),
                            AutoSizeText(
                              "Material: ${data.productDescription}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  "${data.unitPrice}\$",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    PersistentShoppingCart().removeFromCart(
                                      data.productId,
                                    );
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                PersistentShoppingCart()
                                    .incrementCartItemQuantity(
                                        data.productId.toString());
                              },
                              icon: const Icon(Icons.add_circle),
                            ),
                            AutoSizeText(data.quantity.toString()),
                            IconButton(
                              onPressed: () {
                                PersistentShoppingCart()
                                    .decrementCartItemQuantity(
                                        data.productId.toString());
                              },
                              icon: const Icon(Icons.remove_circle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  showEmptyCartMsgWidget: const Center(
                    child: AutoSizeText(
                      "Cart is Empty!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.016),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) {
                  return Column(
                    children: [
                      Visibility(
                        visible: totalAmount == 0.0 ? false : true,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Total Price:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                AutoSizeText(
                                  "${totalAmount.toString()}\$",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Get.height * 0.016),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  final shop = PersistentShoppingCart();

                  Map<String, dynamic> cartData = shop.getCartData();
                  List<PersistentShoppingCartItem> cartItems =
                      cartData['cartItems'];

                  for (var item in cartItems) {
                    print(item.quantity);
                  }

                  // Get.toNamed('/checkout');
                },
                child: const AutoSizeText(
                  "Checkout",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
