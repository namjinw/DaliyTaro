import 'dart:math' as math;

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/page/component/age_enter.dart';
import 'package:dailytarget/page/component/gender_enter.dart';
import 'package:dailytarget/page/component/name_enter.dart';
import 'package:dailytarget/page/widget/base_text_filed.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

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

  Widget progress() => Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: AnimatedOpacity(
      opacity: (_index == 1 || _index == 7) ? 0 : 1,
      duration: Duration(milliseconds: 300),
      child: LinearProgressIndicator(
        value: ((_index - 1) / 5),
        backgroundColor: Colors.grey,
        color: Colors.white,
        minHeight: 8,
      ),
    ),
  );

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
      children: [intro(), nameEnter(), ageEnter(), genderEnter()],
    ),
  );

  Widget nameEnter() =>
      baseEnter('이름을 입력해주세요.', NameEnter(pageController: _pageController,));

  Widget ageEnter() => baseEnter('나이를 입력해주세요.', AgeEnter(pageController: _pageController));

  Widget genderEnter() => baseEnter('성별를 입력해주세요.', GenderEnter(pageController: _pageController));

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
    child: Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: .circular(50),
              color: Colors.white.withAlpha(30),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
                  Text(
                    '이전',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: .w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget intro() =>
      Column(mainAxisAlignment: .center, children: [guideMenu(), button()]);

  Widget button() => Column(
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
              onTap: () => _pageController.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              ),
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
