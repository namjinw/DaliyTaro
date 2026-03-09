import 'dart:ffi';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

import '../widget/base_text_filed.dart';

class GenderEnter extends StatefulWidget {
  final PageController pageController;

  const GenderEnter({super.key, required this.pageController});

  @override
  State<GenderEnter> createState() => _GenderEnterState();
}

class _GenderEnterState extends State<GenderEnter> {
  String gender = UserController.user.value.gender;

  void valid() {
    UserController.user.value.gender = gender;
    setState(() {});
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 300,
      child: Center(child: Row(children: [])),
    );
  }
}
