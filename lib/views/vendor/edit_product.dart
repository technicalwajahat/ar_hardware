import 'dart:io';

import 'package:ar_hardware/models/product_model.dart';
import 'package:ar_hardware/viewModel/product_viewmodel.dart';
import 'package:ar_hardware/widgets/appBar.dart';
import 'package:ar_hardware/widgets/edit_product_fields.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../repository/auth_repository.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());

  final authRepo = Get.put(AuthRepository());
  final _formKey = GlobalKey<FormState>();
  final product = Get.arguments["product"] as ProductModel;

  @override
  Widget build(BuildContext context) {
    final id = product.id;
    final userId = TextEditingController(text: product.userId);
    final productName = TextEditingController(text: product.productName);
    final productPrice = TextEditingController(text: product.productPrice);
    final productMaterial =
        TextEditingController(text: product.productMaterial);
    final productStock = TextEditingController(text: product.productStock);
    var productCategories = product.productCategories;
    var productColor = product.productColor;
    String? colorKey = productViewModel.findKeyFromValue(productColor);
    productViewModel.productColor.value = colorKey.toString();
    final productShipped = TextEditingController(text: product.productShipped);

    return Scaffold(
      appBar: const AppBarWidget(text: "Edit Product"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EditProductFields(
                    name: "Product Name",
                    regExp: "[a-zA-Z ]",
                    enabled: true,
                    validator: "Product Name cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productName,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  EditProductFields(
                    name: "Product Price",
                    regExp: "[0-9]",
                    validator: "Product Price cannot be empty",
                    textInputType: TextInputType.number,
                    controller: productPrice,
                    textInputAction: TextInputAction.next,
                    enabled: true,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  EditProductFields(
                    regExp: "[a-zA-Z ]",
                    name: "Product Material",
                    enabled: true,
                    validator: "Product Material cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productMaterial,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  EditProductFields(
                    regExp: "[0-9]",
                    name: "Product Stock",
                    enabled: true,
                    validator: "Product Stock cannot be empty",
                    textInputType: TextInputType.number,
                    controller: productStock,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  DropdownButtonFormField<String>(
                    autofocus: false,
                    value: productCategories,
                    isExpanded: true,
                    onChanged: productViewModel.onChangedCategory,
                    items: <String>[
                      'Select Category',
                      'Hand Tools',
                      'Power Tools',
                      'Measurement Tools',
                      'Plumping Tools',
                      'Cutting Tools',
                      'Fastening Tools',
                      'Gardening Tools',
                      'Electrical Tools',
                      'Flooring & Paints',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == "Select Category") {
                        return ("Please Choose a Category");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                      hintText: "Categories",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      autofocus: false,
                      value: productViewModel.productColor.value,
                      isExpanded: true,
                      onChanged: productViewModel.colorEnabled.value
                          ? productViewModel.onChangedColor
                          : null,
                      items: [
                        const DropdownMenuItem<String>(
                          value: "No Color",
                          child: AutoSizeText("No Color"),
                        ),
                        ...productViewModel.colorMap.keys
                            .where((color) => color != "No Color")
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: AutoSizeText(value),
                          );
                        }),
                      ],
                      validator: (value) {
                        if (productViewModel.productCategory.value ==
                            "Flooring & Paints") {
                          if (value == "No Color") {
                            return ("Please Choose a Color");
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 0, 15),
                        hintText: "Colors",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  EditProductFields(
                    name: "Product Shipped",
                    regExp: "[a-zA-Z ]",
                    enabled: false,
                    validator: "Product Shipped cannot be empty",
                    textInputType: TextInputType.name,
                    controller: productShipped,
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
                      _updateProduct(
                          context,
                          id!,
                          userId,
                          productName,
                          productPrice,
                          productMaterial,
                          productStock,
                          productShipped);
                    },
                    child: const AutoSizeText(
                      "Update",
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
        productViewModel.storagePath.value = value;
      });
    });
  }

  void _updateProduct(
      BuildContext context,
      String id,
      TextEditingController userId,
      TextEditingController productName,
      TextEditingController productPrice,
      TextEditingController productMaterial,
      TextEditingController productStock,
      TextEditingController productShipped) {
    FocusManager.instance.primaryFocus?.unfocus();
    productViewModel.productColorCode.value =
        productViewModel.getColorCode(productViewModel.productColor.value)!;
    if (_formKey.currentState!.validate()) {
      final productModel = ProductModel(
        userId: userId.text,
        id: id,
        productName: productName.text.trim(),
        productPrice: productPrice.text.trim(),
        productMaterial: productMaterial.text.trim(),
        productShipped: productShipped.text.trim(),
        productStock: productStock.text.trim(),
        productCategories: productViewModel.productCategory.value.trim(),
        productColor: productViewModel.productColorCode,
        productImage: productViewModel.storagePath.value == "Choose Image!"
            ? product.productImage
            : productViewModel.storagePath.value,
      );
      productViewModel.updateProduct(productModel, context);
    }
  }
}
