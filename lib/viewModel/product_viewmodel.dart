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
  var storagePath = "Choose Image!".obs;

  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productMaterial = TextEditingController();
  final productStock = TextEditingController();
  final productShipped = TextEditingController(text: "Ships all over Pakistan");

  final _productsController = StreamController<List<ProductModel>>.broadcast();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;

  // Clear Data
  void clearFormData() {
    productName.clear();
    productPrice.clear();
    productMaterial.clear();
    productStock.clear();
    storagePath.value = "Choose Image!";
  }

  // Upload Product
  Future<String> uploadProduct(File imageFile) async {
    return await _productRepo.uploadProduct("products/", imageFile);
  }

  // Add Product
  Future<void> addProduct(
      ProductModel productModel, BuildContext context) async {
    await _productRepo.addProduct(productModel, context);
  }

  // Fetch Product
  fetchProducts() async {
    var userId = _authRepo.firebaseUser.value!.uid;
    List<ProductModel> products = await _productRepo.getAllProducts(userId);
    _productsController.add(products);
  }

  // Update Product
  Future<void> updateProduct(
      ProductModel productModel, BuildContext context) async {
    await _productRepo.updateProduct(productModel, context);
  }

  // Delete Product
  Future<void> deleteProduct(String id) async {
    await _productRepo.deleteProduct(id);
  }

  @override
  void onClose() {
    _productsController.close();
    super.onClose();
  }
}
