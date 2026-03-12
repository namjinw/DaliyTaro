import 'package:dailytaro/page/home.dart';
import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../controller/userController.dart';
import '../../utils/utils.dart';

class CheckEnter extends StatefulWidget {
  const CheckEnter({super.key});

  @override
  State<CheckEnter> createState() => _CheckEnterState();
}

class _CheckEnterState extends State<CheckEnter> {
  final user = UserController.user.value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        const SizedBox(height: 205),
        check('이름: ${user.name}', 1),
        const SizedBox(height: 15),
        Row(
          children: [
            Flexible(child: check('나이: ${user.age}세', 2)),
            const SizedBox(width: 15),
            SizedBox(width: 50, child: check('', 3, useIcon: true)),
          ],
        ),
        const SizedBox(height: 15),
        check('생일: ${DateFormat('yyyy.MM.dd').format(user.birth)}', 4),
        const SizedBox(height: 15),
        check('태어난 시간: ${DateFormat('HH:mm').format(user.birth)}', 5),
        BaseWidget.button(() {
          checkDialog(context);
        }, 50),
      ],
    );
  }

  Widget check(text, page, {useIcon = false}) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: .circular(50),
      onTap: () {
        UserController.pageIndex.value = page;
        UserController.backIndex = 6;
        setState(() {});
      },
      child: Container(
        width: sizeh(context),
        height: 50,
        alignment: .centerLeft,
        padding: .symmetric(horizontal: useIcon ? 5 : 25),
        decoration: BoxDecoration(
          border: .all(color: Colors.white.withAlpha(180), width: 1.2),
          borderRadius: .circular(65),
        ),
        child: useIcon
            ? SvgPicture.asset(
                'assets/icons/${user.gender == 'M' ? '' : 'fe'}male.svg',
                fit: BoxFit.contain,
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .w500,
                  fontFamily: noto,
                  fontSize: 16,
                ),
              ),
      ),
    ),
  );
}
