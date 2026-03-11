import 'dart:math' as math;

import 'package:dailytaro/page/flows/age_enter.dart';
import 'package:dailytaro/page/flows/name_enter.dart';
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
            guide(),
            page(),
            cloud(),
            bottomBar(),
            UserController.pageIndex.value == 0 || UserController.pageIndex.value == 6 ? SizedBox() : stateButton(),
          ],
        ),
      ),
    ),
  );

  Widget stateButton() => Positioned(
    left: 0,
    right: 0,
    bottom: 60,
    child: AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: UserController.pageIndex.value == 0 || UserController.pageIndex.value == 6 ? 0 : 1,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          stateItem('이전'),
        ],
      ),
    ),
  );

  Widget stateItem(text) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: .circular(40),
      onTap: () {
        setState(() { UserController.pageIndex.value--; });
        print(UserController.pageIndex.value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: stateButtonColor,
          borderRadius: .circular(40)
        ),
        padding: EdgeInsets.only(right: 24, left: 12, top: 12, bottom: 12),
        child: Row(
          spacing: 5,
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset('assets/icons/arrow.svg', height: 25,),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: noto,
                fontWeight: .w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );

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
    List<Widget> _pages = [button('시작하기'), NameEnter(), AgeEnter()];

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Container(
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

  Widget button(text) => Padding(
    padding: const EdgeInsets.only(top: 235.0),
    child: Container(
      width: 190,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: .circular(60),
        boxShadow: [
          BoxShadow(
            color: buttonColor.first.withAlpha(80),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomCenter,
          stops: [0.1, 0.9],
          colors: buttonColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            UserController.pageIndex.value++;
            setState(() {});
          },
          borderRadius: .circular(60),
          child: Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: .w800,
                ),
              ),

              SizedBox(
                width: 25,
                child: Transform(
                  transform: Matrix4.translationValues(30, 0, 0)
                    ..rotateY(math.pi),
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget cloud() => Stack(
    children: [
      right(72, -5),
      right(38, -65),
      left(60, 190),
      left(-5, 210),
      right(-27, 20),
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
