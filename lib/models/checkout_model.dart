import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutModel {
  final String? userId;
  final String? totalAmount;
  final String? totalItems;
  final Timestamp? dateToday;

  CheckoutModel(
      {this.userId, this.totalAmount, this.totalItems, this.dateToday});

  factory CheckoutModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CheckoutModel(
      userId: data['userId'] ?? '',
      totalAmount: data['totalAmount'] ?? '',
      totalItems: data['totalItems'] ?? '',
      dateToday: data['dateToday'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['totalAmount'] = totalAmount;
    data['totalItems'] = totalItems;
    data['dateToday'] = dateToday;
    return data;
  }
}
