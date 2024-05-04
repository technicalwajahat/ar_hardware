import 'dart:async';
import 'dart:io';

import 'package:ar_hardware/models/product_model.dart';
import 'package:ar_hardware/repository/auth_repository.dart';
import 'package:ar_hardware/repository/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/checkout_model.dart';

class ProductViewModel extends GetxController {
  static ProductViewModel get instance => Get.find();

  final ProductRepository _productRepo = Get.put(ProductRepository());
  final AuthRepository _authRepo = Get.put(AuthRepository());
  var storagePath = "Choose Image!".obs;
  var productCategory = 'Select Category'.obs;
  var productColor = 'No Color'.obs;
  RxList<int> productColorCode = [255, 255, 255].obs;
  Rx<bool> colorEnabled = false.obs;

  Map<String, List<int>> colorMap = {
    "No Color": [32, 32, 32],
    "White": [255, 255, 255],
    "Red": [255, 0, 0],
    "Green": [0, 255, 0],
    "Blue": [0, 0, 25],
    "Grey": [128, 128, 128],
    "Bitter Sweet": [255, 102, 102],
    "Dark Orange": [255, 128, 0],
    "Yellow": [255, 255, 0],
    "Indigo": [76, 0, 153],
    "Deep Magenta": [204, 0, 204],
    "Brilliant Azure": [51, 153, 255]
  };

  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productMaterial = TextEditingController();
  final productStock = TextEditingController();
  final productShipped = TextEditingController(text: "Ships all over Pakistan");

  final _productsController = StreamController<List<ProductModel>>.broadcast();
  final _checkoutController = StreamController<List<CheckoutModel>>.broadcast();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;

  Stream<List<CheckoutModel>> get checkoutStream => _checkoutController.stream;

  // Clear Data
  void clearFormData() {
    productName.clear();
    productPrice.clear();
    productMaterial.clear();
    productStock.clear();
    productCategory.value = "Select Category";
    storagePath.value = "Choose Image!";
    productColor.value = "No Color";
    colorEnabled.value = false;
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
    List<ProductModel> products = await _productRepo.getProducts(userId);
    _productsController.add(products);
  }

  // Fetch All Product
  fetchAllProducts(String category) async {
    List<ProductModel> products = await _productRepo.getAllProducts(category);
    _productsController.add(products);
  }

  // Update Product
  Future<void> updateProduct(
      ProductModel productModel, BuildContext context) async {
    await _productRepo.updateProduct(productModel, context);
    clearFormData();
  }

  // Delete Product
  Future<void> deleteProduct(String id) async {
    await _productRepo.deleteProduct(id);
  }

  // Add Checkout Product
  Future<void> checkoutProduct(
      CheckoutModel checkout, BuildContext context, argument) async {
    await _productRepo.checkoutProduct(checkout, context, argument);
  }

  // Fetch Product By User ID
  fetchCheckoutProduct() async {
    var userId = _authRepo.firebaseUser.value!.uid;
    List<CheckoutModel> checkout =
        await _productRepo.getCheckoutProducts(userId);
    _checkoutController.add(checkout);
  }

  // Upload Product
  void uploadProductAPI(
      File imageFile, BuildContext context, List<dynamic> colorCodes) async {
    await _productRepo
        .sendImageToAPI(imageFile, context, colorCodes)
        .then((value) {
      Get.toNamed('/paintWall', arguments: value!['result']);
    });
  }

  // On Change Category
  void onChangedCategory(String? value) {
    if (value != null) {
      productCategory.value = value;
      if (value.endsWith("Flooring & Paints")) {
        colorEnabled.value = true;
      } else {
        colorEnabled.value = false;
        productColor.value = "No Color";
      }
    }
  }

  // On Change Color
  void onChangedColor(String? value) {
    if (value != null) {
      productColor.value = value;
    }
  }

  // Get Color Code
  List<int>? getColorCode(String colorKey) {
    return colorMap[colorKey];
  }

  // Find Key From Value
  String? findKeyFromValue(List? values) {
    if (values == null) {
      return "No Color";
    }

    for (var entry in colorMap.entries) {
      if (listEquals(values, entry.value)) {
        return entry.key;
      }
    }
    return "No Color";
  }

  @override
  void onClose() {
    _productsController.close();
    super.onClose();
  }
}
