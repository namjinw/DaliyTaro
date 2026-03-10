import 'dart:ffi';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../widget/base_text_filed.dart';

class CheckEnter extends StatefulWidget {
  final PageController pageController;

  const CheckEnter({super.key, required this.pageController});

  @override
  State<CheckEnter> createState() => _CheckEnterState();
}

class _CheckEnterState extends State<CheckEnter> {
  @override
  void initState() {
    print(UserController.user.value.gender);
    super.initState();
  }

  final user = UserController.user.value;
  final birth = DateFormat(
    'yyyy.MM.dd',
  ).format(UserController.user.value.birth);
  final birthTime = DateFormat('HH:mm').format(UserController.user.value.birth);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 300,
      child: Center(child: check()),
    );
  }

  void move(index) {
    UserController.returnPageIndex = OnPageIndex.summary;

    widget.pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget check() => Container(
    width: 320,
    child: Column(
      spacing: 10,
      children: [
        checkItem('이름: ${user.name}', () => move(OnPageIndex.name)),
        Row(
          spacing: 15,
          children: [
            Expanded(
              child: checkItem('나이: ${user.age}세', () => move(OnPageIndex.age)),
            ),
            SizedBox(
              width: 55,
              child: checkItem(
                '',
                () => move(OnPageIndex.gender),
                useIcon: true,
              ),
            ),
          ],
        ),
        checkItem('생일: ${birth}', () => move(OnPageIndex.birth)),
        checkItem('태어난 시간: ${birthTime}', () => move(OnPageIndex.birthTime)),
      ],
    ),
  );

  Widget checkItem(text, ontap, {useIcon = false}) {
    final gender = user.gender == 'M'
        ? 'male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg'
        : 'female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg';

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: sizew(context),
        alignment: useIcon ? .center : .centerLeft,
        padding: useIcon
            ? .zero
            : EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: .circular(30),
          border: .all(color: Colors.white.withAlpha(190), width: 1.2),
        ),
        child: useIcon
            ? SizedBox(
                height: 50,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/$gender',
                    fit: .cover,
                    height: 40,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: .w500,
                ),
              ),
      ),
    );
  }
}
