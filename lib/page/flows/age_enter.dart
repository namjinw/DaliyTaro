import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AgeEnter extends StatefulWidget {
  const AgeEnter({super.key});

  @override
  State<AgeEnter> createState() => _AgeEnterState();
}

class _AgeEnterState extends State<AgeEnter> {
  final TextEditingController age = TextEditingController();

  void valid(String text) {
    final value = text.trim();
    final int? intValue = int.tryParse(value);
    final icon = Icons.error_outline;


    if (value.isEmpty) {
      ShowSnackerBar(context, icon, '나이를 입력해 주세요!');
    } else if (intValue == null) {
      ShowSnackerBar(context, icon, '숫자를 입력해 주세요!');
    } else if (intValue <= 0 || intValue > 100) {
      ShowSnackerBar(context, icon, '나이는 1세부터 99세 사이로 입력해 주세요!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        BaseWidget.baseFiled(age, '이름을 입력해주세요.', context, () => valid(age.text)),
        const SizedBox(height: 130),
      ],
    );
  }
}
