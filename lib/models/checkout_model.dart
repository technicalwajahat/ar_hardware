import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutModel {
  final String? userId;
  final String? totalAmount;
  final String? totalItems;

  CheckoutModel({this.userId, this.totalAmount, this.totalItems});

  factory CheckoutModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CheckoutModel(
      userId: data['userId'] ?? '',
      totalAmount: data['totalAmount'] ?? '',
      totalItems: data['totalItems'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['totalAmount'] = totalAmount;
    data['totalItems'] = totalItems;
    return data;
  }
}
