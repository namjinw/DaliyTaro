import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

import '../widget/base_text_filed.dart';

class NameEnter extends StatefulWidget {
  final PageController pageController;
  const NameEnter({super.key, required this.pageController});

  @override
  State<NameEnter> createState() => _NameEnterState();
}

class _NameEnterState extends State<NameEnter> {
  final TextEditingController name = TextEditingController();

  void valid() {
    final text = name.text.trim();
    if (text.isEmpty) {
      ShowSnacker(context, Icons.error_outline, '이름을 입력해주세요!');
      return;
    }
    if (text.length < 2 || text.length > 20) {
      ShowSnacker(context, Icons.error_outline, '이름 최소 2자에서 20자 이내입니다!');
      return;
    }
    UserController.user.value.name = text;
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

    print('이동');
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 300,
      child: Center(
        child: BaseTextFiled(
          controller: name,
          label: '이름을 입력해주세요.',
          validate: valid,
        ),
      ),
    );
  }
}
