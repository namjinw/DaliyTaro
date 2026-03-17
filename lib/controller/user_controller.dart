import 'dart:convert';

import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static int? returnPageIndex;
  static ValueNotifier<User> user = ValueNotifier(User.empty());
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    await getUser();
    await SoulController.getSoulCardInfo();
    await SoulController.getFruitCardInfo();
    await SoulController.getLoveCardInfo();
  }

  static Future<void> getUser() async {
    final newUser = prefs.getString('user');

    if (newUser != null) {
      final Map<String, dynamic> json = jsonDecode(newUser);
      user.value = User.fromJson(json);
    }
    return;
  }
  
  static Future<void> save() async {
    final saveUser = user.value;
    // sharedPreferences를 json으로 저장
    final String jsonData = jsonEncode(saveUser.toJson());
    await prefs.setString('user', jsonData);
  }

  static Future<void> addMoon(int moon) async {
    final newUser = user.value;
    final moonCount = newUser.moon + moon;

    newUser.moon = moonCount < 0 ? 0 : moonCount;

    user.value = User.fromJson(newUser.toJson());

    await save();
  }
}

class OnPageIndex {
  static const name = 1;
  static const age = 2;
  static const gender = 3;
  static const birth = 4;
  static const birthTime = 5;
  static const summary = 6;
}