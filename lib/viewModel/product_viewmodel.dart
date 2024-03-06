import 'dart:async';
import 'dart:io';

import 'package:ar_hardware/models/product_model.dart';
import 'package:ar_hardware/repository/auth_repository.dart';
import 'package:ar_hardware/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  static ProductViewModel get instance => Get.find();

  final ProductRepository _productRepo = Get.put(ProductRepository());
  final AuthRepository _authRepo = Get.put(AuthRepository());

  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productMaterial = TextEditingController();
  final productShipped = TextEditingController(text: "Ships all over Pakistan");

  Future<String> uploadProduct(File imageFile) async {
    return await _productRepo.uploadProduct("products/", imageFile);
  }

  addProduct(ProductModel productModel, BuildContext context) async {
    await _productRepo.addProduct(productModel, context);
  }

  Future<List<ProductModel>> fetchProducts() async {
    var userId = _authRepo.firebaseUser.value!.uid;
    return await _productRepo.getAllProducts(userId);
  }
}
