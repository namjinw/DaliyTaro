import 'package:dailytarget/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  static int? returnPageIndex;
  static ValueNotifier<User> user = ValueNotifier(User.empty());
}

class OnPageIndex {
  static const name = 1;
  static const age = 2;
  static const gender = 3;
  static const birth = 4;
  static const birthTime = 5;
  static const summary = 6;
}