import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  final String? userId;
  final String? productName;
  final String? productPrice;
  final String? productMaterial;
  final String? productShipped;
  final String? productStock;
  late final String? productImage;

  ProductModel({
    this.id,
    this.userId,
    required this.productName,
    required this.productPrice,
    required this.productMaterial,
    required this.productShipped,
    required this.productStock,
    required this.productImage,
  });

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: data['id'] ?? document.id,
      userId: data['userId'] ?? '',
      productName: data['productName'] ?? '',
      productPrice: data['productPrice'] ?? '',
      productMaterial: data['productMaterial'] ?? '',
      productShipped: data['productShipped'] ?? '',
      productStock: data['productStock'] ?? '',
      productImage: data['productImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['productMaterial'] = productMaterial;
    data['productShipped'] = productShipped;
    data['productStock'] = productStock;
    data['productImage'] = productImage;
    return data;
  }
}
