import 'dart:io';

import 'package:ar_hardware/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

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

  // Get All Products
  Future<List<ProductModel>> getAllProducts(String userId) async {
    final querySnapshot = await _db
        .collection("products")
        .where("userId", isEqualTo: userId)
        .get();

    final receiptData =
        querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    return receiptData;
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
}
