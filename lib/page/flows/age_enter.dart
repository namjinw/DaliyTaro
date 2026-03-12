import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import '../../controller/userController.dart';
import '../../utils/utils.dart';

class AgeEnter extends StatefulWidget {
  const AgeEnter({super.key});

  @override
  State<AgeEnter> createState() => _AgeEnterState();
}

class _AgeEnterState extends State<AgeEnter> {
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _next() {
    final age = _ageController.text.trim();

    if (age.isEmpty) {
      _showMessage("나이을 입력해주세요!");
      return;
    }
    if (int.tryParse(age) == null) {
      _showMessage("숫자를 입력해 주세요!");
      return;
    }
    if (int.parse(age) < 1 || int.parse(age) > 100) {
      _showMessage("나이는 1세부터 99세 사이로 입력해 주세요!");
      return;
    }

    UserController.user.value.age = int.tryParse(age) ?? 0;

    if (UserController.backIndex != null) {
      UserController.pageIndex.value = UserController.backIndex!;
      UserController.backIndex = null;
      FocusScope.of(context).unfocus();
      setState(() {});
      return;
    }

    setState(() {});
    print(UserController.user.value.age);
    
    FocusScope.of(context).unfocus();
    UserController.pageIndex.value++;
  }

  void _showMessage(String text) {
    ShowSnackerBar(context, Icons.error_outline, text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseWidget.baseFiled(
          _ageController,
          '나이를 입력해주세요.',
          context,
          _next,
        ),
        const SizedBox(height: 130),
      ],
    );
  }
}