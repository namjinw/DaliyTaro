import 'dart:ffi';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      top: 350,
      child: Center(
        child: Row(
          mainAxisAlignment: .center,
          spacing: 25,
          children: [
            genderTap(
              70.0,
              'female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
              'F',
            ),
            genderTap(
              70.0,
              'male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
              'M',
            ),
          ],
        ),
      ),
    );
  }

  Widget genderTap(size, svg, genders) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => setState(() {
        gender = genders;
        valid();
      }),
      borderRadius: .circular(16),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: .all(color: Colors.white.withAlpha(150), width: 1),
          borderRadius: .circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/$svg',
            fit: BoxFit.contain,
            width: size - 25,
            colorFilter: ColorFilter.mode(
              Colors.white.withAlpha(200),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    ),
  );
}
