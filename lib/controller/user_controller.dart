import 'package:dailytarget/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  static ValueNotifier<User> user = ValueNotifier(User.empty());
}