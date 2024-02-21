import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Start {
  final Image image;
  final String title;
  final String description;

  Start({required this.image, required this.title, required this.description});
}

class UserModel {
  final String? id;
  final String email;
  final String name;
  final String password;
  final String profilePic;
  final bool isNewUser;
  final String provider;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.profilePic,
    required this.isNewUser,
    required this.provider,
  });

  toJson() {
    return {
      "username": name,
      "Email": email,
      "password": password,
      "profilePic": profilePic,
      "isNewUser": isNewUser,
      "provider": provider
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        name: data["username"],
        password: data["password"],
        profilePic: data["profilePic"],
        isNewUser: data["isNewUser"],
        provider: data["provider"],
        );
  }
}
