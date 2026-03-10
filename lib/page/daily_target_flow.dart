import 'dart:math' as math;

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/page/component/age_enter.dart';
import 'package:dailytarget/page/component/birth_enter.dart';
import 'package:dailytarget/page/component/birth_time_enter.dart';
import 'package:dailytarget/page/component/check_enter.dart';
import 'package:dailytarget/page/component/gender_enter.dart';
import 'package:dailytarget/page/component/name_enter.dart';
import 'package:dailytarget/page/home.dart';
import 'package:dailytarget/page/widget/base_text_filed.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyTargetFlowPage extends StatefulWidget {
  const DailyTargetFlowPage({super.key});

  @override
  State<DailyTargetFlowPage> createState() => _DailyTargetFlowPageState();
}

class _DailyTargetFlowPageState extends State<DailyTargetFlowPage> {
  bool moonShow = false;
  bool cloudShow = false;
  bool logoShow = false;
  bool btnShow = false;

  final PageController _pageController = PageController();
  int _index = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500));

      moonShow = true;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 500));

      cloudShow = true;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 600));

      logoShow = true;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 600));

      btnShow = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserController.user,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              back(),
              SafeArea(child: flowItem()),
            ],
          ),
        );
      },
    );
  }

  Widget back() => SizedBox.expand(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: background,
          stops: [0, 0.7],
        ),
      ),
      child: AnimatedOpacity(
        opacity: cloudShow ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          transform: .translationValues(0, cloudShow ? 0 : 20, 0),
          child: Cloud(),
        ),
      ),
    ),
  );

  Widget flowItem() => Stack(children: [moon(), guide(), progress()]);

  Widget progress() {
    final totalStep = 5;
    final count = (_index == 1 || _index == 7) ? 0 : _index - 1;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedOpacity(
        opacity: (_index == 1 || _index == 7) ? 0 : 1,
        duration: Duration(milliseconds: 300),
        child: Container(
          width: sizew(context),
          height: 8,
          color: Colors.white.withAlpha(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(totalStep * 2 - 1, (index) {
              if (index.isOdd) {
                return SizedBox(width: 2,);
              }
              print(index);
              print(index ~/ 2);
              return inputState(index ~/ 2 + 1, count);
            }),
          ),
        ),
      ),
    );
  }

  Widget inputState(index, count) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: index <= count ? Colors.white : Colors.transparent,
          borderRadius: .circular(8),
        ),
      ),
    );
  }

  Widget guide() => Align(
    alignment: .center,
    child: PageView(
      controller: _pageController,
      onPageChanged: (value) {
        _index = value + 1;
        print(_index);
        setState(() {});
      },
      physics: NeverScrollableScrollPhysics(),
      children: [
        intro(),
        nameEnter(),
        ageEnter(),
        genderEnter(),
        birthEnter(),
        birthTimeEnter(),
        checkEnter(),
      ],
    ),
  );

  Widget nameEnter() =>
      baseEnter('이름을 입력해주세요.', NameEnter(pageController: _pageController));

  Widget ageEnter() =>
      baseEnter('나이를 입력해주세요.', AgeEnter(pageController: _pageController));

  Widget genderEnter() =>
      baseEnter('성별를 입력해주세요.', GenderEnter(pageController: _pageController));

  Widget birthEnter() =>
      baseEnter('태어난 날짜를 입력해주세요.', BirthEnter(pageController: _pageController));

  Widget birthTimeEnter() => baseEnter(
    '태어난 시간을 입력해주세요.',
    BirthTimeEnter(pageController: _pageController),
  );

  Widget checkEnter() => baseEnter(
    '입력한 정보가 맞는지 해주세요.',
    CheckEnter(pageController: _pageController),
  );

  Widget baseEnter(text, child) => Stack(
    children: [
      Positioned(right: 0, left: 0, top: 100, child: logo(text)),
      child,
      prevButton(),
    ],
  );

  Widget prevButton() => Positioned(
    bottom: 70,
    right: 0,
    left: 0,
    child: _index == 7
        ? button(
            () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            ),
          )
        : Row(
            spacing: 15,
            mainAxisAlignment: .center,
            children: [prev(), _index == 6 ? NoKnow() : SizedBox()],
          ),
  );

  prev() => bottomButton(
    () {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    },
    '이전',
    false,
  );

  NoKnow() => bottomButton(
    () {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    },
    '잘 모르겠어요',
    true,
  );

  Widget bottomButton(ontap, text, useRight) => Center(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(50),
        onTap: ontap,
        child: Container(
          padding: .symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: .circular(50),
            color: Colors.white.withAlpha(30),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: .center,
              spacing: 5,
              children: [
                !useRight
                    ? Icon(Icons.arrow_back_ios, color: Colors.white, size: 22)
                    : SizedBox(),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: .w500,
                  ),
                ),
                useRight
                    ? Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 22,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget intro() => Column(
    mainAxisAlignment: .center,
    children: [
      guideMenu(),
      button(
        () => _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        ),
      ),
    ],
  );

  Widget button(ontap) => Column(
    children: [
      SizedBox(height: 80),
      AnimatedOpacity(
        opacity: btnShow ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: Container(
          width: 180,
          height: 55,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: moonColor.withAlpha(50),
                offset: Offset(0, 10),
                blurRadius: 18,
              ),
            ],
            borderRadius: .circular(60),
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomCenter,
              colors: [
                Color(0xFF9A7D94), // 왼쪽 밝은 부분
                Color(0xFF3C1463), // 오른쪽 진한 보라
              ],
              stops: [0.0, 1.0],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: .circular(60),
              onTap: ontap,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    '시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: nanun,
                      fontWeight: .w700,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget guideMenu() => AnimatedOpacity(
    opacity: logoShow ? 1 : 0,
    duration: Duration(milliseconds: 450),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      transform: .translationValues(0, logoShow ? 0 : 20, 0),
      child: logo('운명을 엿볼 시간이에요.'),
    ),
  );

  Widget logo(text) => Column(
    children: [
      Transform.translate(
        offset: Offset(0, 15),
        child: SizedBox(
          width: 220,
          child: Image.asset(
            'assets/images/Daily Tarot.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      SizedBox(
        width: 75,
        child: Image.asset('assets/images/graphic.png', fit: BoxFit.contain),
      ),
      Transform.translate(
        offset: Offset(0, -15),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: nanun,
          ),
        ),
      ),
    ],
  );

  Widget moon() => Positioned(
    left: 0,
    top: -10,
    child: AnimatedOpacity(
      opacity: moonShow ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Image.asset('assets/images/moon.png', fit: BoxFit.contain),
      ),
    ),
  );
}
