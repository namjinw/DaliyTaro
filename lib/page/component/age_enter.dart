import 'dart:ffi';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

import '../widget/base_text_filed.dart';

class AgeEnter extends StatefulWidget {
  final PageController pageController;
  const AgeEnter({super.key, required this.pageController});

  @override
  State<AgeEnter> createState() => _AgeEnterState();
}

class _AgeEnterState extends State<AgeEnter> {
  final TextEditingController age = TextEditingController();

  void valid() {
    final text = age.text.trim();
    if (text.isEmpty) {
      ShowSnacker(context, Icons.error_outline, '나이를 입력해주세요!');
      return;
    }
    if (int.tryParse(text) == null) {
      ShowSnacker(context, Icons.error_outline, '숫자를 입력해주세요!');
      return;
    }
    if (int.parse(text) < 1 || int.parse(text) > 110) {
      ShowSnacker(context, Icons.error_outline, '제대로된 나이를 입력해주세요!');
      return;
    }
    UserController.user.value.age = int.parse(text);
    setState(() {});
    final re = UserController.returnPageIndex;
    print(re);

    if (re != null) {
      UserController.returnPageIndex = null;
      widget.pageController.animateToPage(
        re,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 300,
      child: Center(
        child: BaseTextFiled(
          controller: age,
          label: '나이를 입력해주세요.',
          validate: valid,
        ),
      ),
    );
  }
}
