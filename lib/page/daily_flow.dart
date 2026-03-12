import 'dart:math' as math;

import 'package:dailytaro/page/flows/age_enter.dart';
import 'package:dailytaro/page/flows/birth_enter.dart';
import 'package:dailytaro/page/flows/birth_time_enter.dart';
import 'package:dailytaro/page/flows/check_enter.dart';
import 'package:dailytaro/page/flows/gender_enter.dart';
import 'package:dailytaro/page/flows/name_enter.dart';
import 'package:dailytaro/utils/base_widget.dart';
import 'package:dailytaro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/userController.dart';

class DailyFlowPage extends StatefulWidget {
  const DailyFlowPage({super.key});

  @override
  State<DailyFlowPage> createState() => _DailyFlowPageState();
}

class _DailyFlowPageState extends State<DailyFlowPage> {
  List<String> _pageText = [
    '운명을 엿볼 시간이에요.',
    '이름을 입력해주세요.',
    '나이를 입력해주세요.',
    '성별을 선택해주세요.',
    '태어난 날짜를 입력해주세요.',
    '태어난 시간를 입력해주세요.',
    '입력한 정보가 맞는지 확인해주세요.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: flow(),
    );
  }

  Widget flow() => ValueListenableBuilder(
    valueListenable: UserController.pageIndex,
    builder: (context, value, child) => SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.3, 0.6],
            begin: .topCenter,
            end: .bottomCenter,
            colors: background,
          ),
        ),
        child: Stack(
          alignment: .center,
          children: [
            moon(),
            cloud(),
            guide(),
            page(),
            bottomBar(),
            UserController.pageIndex.value == 0 ||
                    UserController.pageIndex.value == 6
                ? SizedBox()
                : stateButton(),
          ],
        ),
      ),
    ),
  );

  Widget stateButton() {
    final stateShow =
        UserController.pageIndex.value == 0 ||
        UserController.pageIndex.value == 6;

    final backState = UserController.backIndex != null;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 60,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: backState ? 0 : (stateShow ? 0 : 1),
        child: Row(
          spacing: 12,
          mainAxisAlignment: .center,
          children: [
            stateItem('이전', () {
              UserController.pageIndex.value--;
              print(UserController.pageIndex.value);
            }),
            UserController.pageIndex.value == 5
                ? stateItem('잘 모르겠어요', () {
                    UserController.pageIndex.value++;
                    print(UserController.pageIndex.value);
                  }, useRightArro: true)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget stateItem(text, ontap, {useRightArro = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(40),
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            color: stateButtonColor,
            borderRadius: .circular(40),
          ),
          padding: .symmetric(horizontal: 16, vertical: 12),
          child: Row(
            spacing: 5,
            mainAxisAlignment: .center,
            children: [
              !useRightArro
                  ? SizedBox(
                      width: 25,
                      child: SvgPicture.asset('assets/icons/arrow.svg'),
                    )
                  : SizedBox(),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: noto,
                  fontWeight: .w500,
                ),
              ),
              useRightArro
                  ? SizedBox(
                      width: 25,
                      child: Transform.flip(
                        flipX: true,
                        child: SvgPicture.asset('assets/icons/arrow.svg'),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBar() => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: AnimatedOpacity(
      opacity:
          UserController.pageIndex.value == 0 ||
              UserController.pageIndex.value == 6
          ? 0
          : 1,
      duration: Duration(milliseconds: 400),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 8,
        child: Row(
          mainAxisAlignment: .start,
          children: List.generate(9, (index) {
            if (index.isOdd) {
              return SizedBox(width: 1);
            }
            return bottomItem(index ~/ 2);
          }),
        ),
      ),
    ),
  );

  Widget bottomItem(index) {
    final count =
        UserController.pageIndex.value == 0 ||
            UserController.pageIndex.value == 6
        ? 0
        : UserController.pageIndex.value;

    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: index < count ? Colors.white : Colors.transparent,
          borderRadius: .circular(10),
        ),
      ),
    );
  }

  Widget page() {
    List<Widget> _pages = [
      BaseWidget.button(() {
        UserController.pageIndex.value++;
      }, 235.0),
      NameEnter(),
      AgeEnter(),
      GenderEnter(),
      BirthEnter(),
      BirthTimeEnter(),
      CheckEnter(),
    ];

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Container(
            key: ValueKey(UserController.pageIndex.value),
            padding: EdgeInsets.symmetric(horizontal: 54),
            child: _pages[UserController.pageIndex.value],
          ),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ],
    );
  }

  Widget cloud() => Stack(
    children: [
      right(62, -5),
      right(28, -65),
      left(50, 190),
      left(-15, 210),
      right(-37, 20),
    ],
  );

  Widget right(double bottom, double right) => Positioned(
    bottom: bottom,
    right: right,
    child: SizedBox(
      width: 235,
      child: Image.asset('assets/images/cloud.png', fit: BoxFit.contain),
    ),
  );

  Widget left(double bottom, double left) => Positioned(
    bottom: bottom,
    left: left,
    child: Transform(
      transform: .rotationY(math.pi),
      child: SizedBox(
        width: 235,
        child: Image.asset('assets/images/cloud.png', fit: BoxFit.contain),
      ),
    ),
  );

  Widget guide() => AnimatedPositioned(
    duration: Duration(milliseconds: 350),
    curve: Curves.easeOutBack,
    left: 0,
    top: UserController.pageIndex.value == 0 ? 245 : 150,
    right: 0,
    child: Column(
      mainAxisAlignment: .center,
      children: [
        SizedBox(
          width: 200,
          child: Image.asset(
            'assets/images/Daily Tarot.png',
            fit: BoxFit.contain,
          ),
        ),
        Transform.translate(
          offset: Offset(0, -12),
          child: SizedBox(
            width: 60,
            child: Image.asset(
              'assets/images/graphic.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -20),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              _pageText[UserController.pageIndex.value],
              key: ValueKey(_pageText[UserController.pageIndex.value]),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: .w800,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget moon() => Positioned(
    top: 0,
    left: 0,
    child: SizedBox(
      width: 140,
      child: Image.asset('assets/images/moon.png', fit: BoxFit.contain),
    ),
  );
}
