import 'dart:convert';
import 'dart:io';

import 'package:ar_hardware/models/checkout_model.dart';
import 'package:ar_hardware/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../utils/utils.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> sendImageToAPI(
      File imageFile, BuildContext context, List<int> colorCodes) async {
    try {
      List<int> imageBytes = imageFile.readAsBytesSync();

      String base64image = base64Encode(imageBytes);
      List<int> colorPicked = colorCodes;

      var response =
          await http.post(Uri.parse("http://10.0.2.2:8001/getProcessedImage"),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(
                {"img_data": base64image, "color_picked": colorPicked},
              ));

      if (response.statusCode == 200) {
        Utils.snackBar("Image Sent Successfully", context);
        return jsonDecode(response.body);
      } else {
        Utils.snackBar(
            "Failed to send image. Error: ${response.body}", context);
        return null;
      }
    } catch (e) {
      Utils.snackBar("Error sending image: $e", context);
      print(e);
      return null;
    }
  }

  Future<String> uploadProduct(String path, File image) async {
    final filename = image.path.split('/').last;
    final ref = FirebaseStorage.instance.ref(path).child(filename);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  }

  // Add Product
  addProduct(ProductModel productModel, BuildContext context) {
    _db.collection("products").add(productModel.toJson()).then((_) {
      Utils.snackBar("Product Added Successfully!.", context);
      Get.back();
    });
  }

  // Get Products by ID
  Future<List<ProductModel>> getProducts(String userId) async {
    final querySnapshot = await _db
        .collection("products")
        .where("userId", isEqualTo: userId)
        .get();

    final receiptData =
        querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    return receiptData;
  }

  // Get All Products
  Future<List<ProductModel>> getAllProducts(String category) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (category == 'All') {
      querySnapshot = await _db
          .collection("products")
          .where("productStock", isGreaterThan: '0')
          .get();
    } else {
      querySnapshot = await _db
          .collection("products")
          .where("productCategories", isEqualTo: category)
          .where("productStock", isGreaterThan: '0')
          .get();
    }
    final receiptData =
        querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    return receiptData;
  }

  // Fetch Checkout
  Future<List<CheckoutModel>> getCheckoutProducts(String userId) async {
    final querySnapshot = await _db
        .collection("checkout")
        .where("userId", isEqualTo: userId)
        .get();
    final checkoutData =
        querySnapshot.docs.map((e) => CheckoutModel.fromSnapshot(e)).toList();
    return checkoutData;
  }

  // Update Product
  updateProduct(ProductModel productModel, BuildContext context) async {
    await _db
        .collection("products")
        .doc(productModel.id)
        .update(productModel.toJson())
        .then((value) {
      Utils.snackBar("Product Updated Successfully!.", context);
      Get.back();
    });
  }

  // Delete Product
  Future<void> deleteProduct(String id) async {
    await _db.collection("products").doc(id).delete();
  }

  // Add Checkout Product
  checkoutProduct(
      CheckoutModel checkout, BuildContext context, argument) async {
    final _db = FirebaseFirestore.instance;

    for (var item in argument) {
      final docRef = _db.collection("products").doc(item['productId']);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final currentStockString = docSnapshot.data()?['productStock'];

        final currentStock = int.tryParse(currentStockString) ?? 0;
        final newStock = currentStock - item['quantity'];
        await docRef.update({'productStock': newStock.toString()});
      }
    }

    _db.collection("checkout").add(checkout.toJson()).then((_) {
      PersistentShoppingCart().clearCart();
      Utils.snackBar("Order Completed!.", context);
      Get.offAllNamed('/userDashboard');
    });
  }
}
