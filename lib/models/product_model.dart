import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  final String? productName;
  final String? productPrice;
  final String? productMaterial;
  final String? productShipped;
  late final String? productImage;

  ProductModel({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productMaterial,
    required this.productShipped,
    required this.productImage,
  });

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      productName: data['productName'] ?? '',
      productPrice: data['productPrice'] ?? '',
      productMaterial: data['productMaterial'] ?? '',
      productShipped: data['productShipped'] ?? '',
      productImage: data['productImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['productMaterial'] = productMaterial;
    data['productShipped'] = productShipped;
    data['productImage'] = productImage;
    return data;
  }
}
