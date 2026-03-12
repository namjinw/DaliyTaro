import 'package:dailytaro/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  static ValueNotifier<User> user = ValueNotifier(User.empty());
  static ValueNotifier<int> pageIndex = ValueNotifier(0);
  static int? backIndex;
}