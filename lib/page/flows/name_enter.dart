import 'package:dailytaro/utils/base_widget.dart';
import 'package:dailytaro/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../controller/userController.dart';

class NameEnter extends StatefulWidget {
  const NameEnter({super.key});

  @override
  State<NameEnter> createState() => _NameEnterState();
}

class _NameEnterState extends State<NameEnter> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _next() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showMessage("이름을 입력해주세요!");
      return;
    }
    if (name.length < 2 || name.length > 20) {
      _showMessage("이름은 2자부터 20자까지 사이입니다!");
      return;
    }

    UserController.user.value.name = name;
    print(UserController.user.value.name);

    if (UserController.backIndex != null) {
      UserController.pageIndex.value = UserController.backIndex!;
      UserController.backIndex = null;
      FocusScope.of(context).unfocus();
      setState(() {});
      return;
    }

    FocusScope.of(context).unfocus();
    UserController.pageIndex.value++;
    setState(() {});
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
          _nameController,
          '이름을 입력해주세요.',
          context,
          _next,
        ),
        const SizedBox(height: 130,)
      ],
    );
  }
}