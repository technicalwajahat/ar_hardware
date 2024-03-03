import 'dart:io';

import 'package:ar_hardware/models/product_model.dart';
import 'package:ar_hardware/utils/utils.dart';
import 'package:ar_hardware/viewModel/product_viewmodel.dart';
import 'package:ar_hardware/widgets/appBar.dart';
import 'package:ar_hardware/widgets/product_fields.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../repository/auth_repository.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());
  final _formKey = GlobalKey<FormState>();
  final authRepo = Get.put(AuthRepository());
  String? storagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: "Add Product"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProductFields(
                    name: "Product Name",
                    regExp: "[a-zA-Z ]",
                    enabled: true,
                    validator: "Product Name cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productViewModel.productName,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ProductFields(
                    name: "Product Price",
                    regExp: "[0-9]",
                    validator: "Product Price cannot be empty",
                    textInputType: TextInputType.number,
                    controller: productViewModel.productPrice,
                    textInputAction: TextInputAction.next,
                    enabled: true,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ProductFields(
                    regExp: "[a-zA-Z ]",
                    name: "Product Material",
                    enabled: true,
                    validator: "Product Material cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productViewModel.productMaterial,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ProductFields(
                    name: "Product Shipped",
                    regExp: "[a-zA-Z ]",
                    enabled: false,
                    validator: "Product Shipped cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productViewModel.productShipped,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    child: const AutoSizeText(
                      "Choose Image",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
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
                      if (storagePath == null) {
                        Utils.snackBar("Please choose an image", context);
                      } else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          final productModel = ProductModel(
                            id: authRepo.firebaseUser.value!.uid,
                            productName:
                                productViewModel.productName.text.trim(),
                            productPrice:
                                "${productViewModel.productPrice.text.trim()} \$",
                            productMaterial:
                                productViewModel.productMaterial.text.trim(),
                            productShipped:
                                productViewModel.productShipped.text.trim(),
                            productImage: storagePath ?? "Choose Image",
                          );
                          productViewModel.addProduct(productModel, context);
                        }
                      }
                    },
                    child: const AutoSizeText(
                      "Add Product",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pickImageFromGallery() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100)
        .then((value) {
      productViewModel.uploadProduct(File(value!.path)).then((value) {
        storagePath = value;
      });
    });
  }
}
