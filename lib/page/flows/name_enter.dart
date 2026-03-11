import 'package:dailytaro/controller/userController.dart';
import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class NameEnter extends StatefulWidget {
  const NameEnter({super.key});

  @override
  State<NameEnter> createState() => _NameEnterState();
}

class _NameEnterState extends State<NameEnter> {
  final TextEditingController name = TextEditingController();

  void valid(String text) {
    final value = text.trim();
    final icon = Icons.error_outline;

    if (value.isEmpty) {
      ShowSnackerBar(context, icon, '이름을 입력해주세요!');
    } else if (value.length < 2 || value.length > 20) {
      ShowSnackerBar(context, icon, '이름을 2자 이상 20자 이하로 입력해 주세요!');
    }
    UserController.pageIndex.value++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        BaseWidget.baseFiled(name, '이름을 입력해주세요.', context, () => valid(name.text)),
        const SizedBox(height: 130),
      ],
    );
  }
}
