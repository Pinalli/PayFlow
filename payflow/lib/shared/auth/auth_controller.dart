// ignore_for_file: prefer_const_constructors, unused_field, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_models.dart';

class AuthController {
  var _isAithenticated = false;

  UserModel? _user;
  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJason(json));
      return;
    } else {
      setUser(context, null);
    }
  }
}
