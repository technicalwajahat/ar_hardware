import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final String? role;
  final String? password;

  UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      role: data['role'] ?? '',
      password: data['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['role'] = role;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
