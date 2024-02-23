import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  late final String? name;
  late final String? username;
  late final String? email;
  late final String? phone;
  late final String? role;
  late final String? password;

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
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['role'] = role;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
