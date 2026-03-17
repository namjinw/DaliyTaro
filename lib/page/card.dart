import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/page/home.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../util/util.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final num = SoulController.type == TarotType.fruit
      ? SoulController.selectedNum
      : SoulController.loveNum;
  final info = SoulController.type == TarotType.fruit
      ? SoulController.fruitCard![SoulController.selectedNum!]
      : SoulController.loveCard![SoulController.loveNum!];
  bool next = false;

  String space(String text) {
    final words = text.split(' ');
    List<String> value = [];
    String current = '';

    for (var i in words) {
      current = current.isEmpty ? i : current += ' $i';
      if (i.endsWith('.')) {
        value.add(current.trim());
        current = '';
      }
    }

    return value.join('\n\n');
  }

  void Show() {
    next = !next;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: background,
            ),
          ),
          child: Stack(
            children: [
              cloud(),
              cardInfo(),
              beforeButton(),
              after(),
              beforeTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget beforeButton() => Positioned(
    left: 0,
    right: 0,
    bottom: 220,
    child: AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: next ? 0 : 1,
      child: IgnorePointer(
        ignoring: next ? true : false,
        child: Center(
          child: button(() {
            Show();
          }),
        ),
      ),
    ),
  );

  Widget after() => AnimatedOpacity(
    opacity: next ? 1 : 0,
    duration: Duration(milliseconds: 300),
    child: IgnorePointer(
      ignoring: next ? false : true,
      child: Stack(
        children: [
          cardStory(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                afterButton(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                    (route) => false,
                  );
                }, '돌아가기'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget afterButton(ontap, text) => Center(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(50),
        onTap: ontap,
        child: Container(
          padding: .symmetric(horizontal: 35, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: .circular(50),
            color: Colors.white.withAlpha(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: .w500,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget cardStory() => Positioned(
    left: 50,
    right: 50,
    bottom: 170,
    child: Container(
      height: 280,
      child: SingleChildScrollView(
        physics: RangeMaintainingScrollPhysics(),
        child: Text(
          '${space(info.storytelling)}',
          style: TextStyle(
            color: Colors.white.withAlpha(210),
            fontSize: 15,
            height: 1.6,
            fontWeight: .w700,
          ),
        ),
      ),
    ),
  );

  Widget beforeTitle() => Positioned(
    left: 0,
    right: 0,
    top: 20,
    child: Column(
      mainAxisSize: .min,
      children: [
        Image.asset('assets/images/graphic.png', width: 60),
        Transform.translate(
          offset: Offset(0, -8),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: Column(
              key: ValueKey(next),
              children: [
                Text(
                  next ? '카드풀이' : '아래에 타로카드를 선택하셨군요',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: nanun,
                    fontWeight: .w700,
                    height: 1.2,
                  ),
                ),
                Text(
                  next ? '' : '결과를 확인해보세요',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: nanun,
                    fontWeight: .w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget cardInfo() => AnimatedPositioned(
    duration: Duration(milliseconds: 550),
    curve: Curves.easeOutCubic,
    left: 0,
    right: 0,
    top: next ? 140 : 195,
    child: Center(
      child: Column(
        children: [
          Hero(
            tag: num!,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 550),
              curve: Curves.easeOutCubic,
              width: next ? 95 : 135,
              height: next ? 150 : 210,
              decoration: BoxDecoration(borderRadius: .circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/tarot_cards/${info.image}',
                fit: .cover,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${info.number}. ${info.name}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: .w700,
              fontFamily: nanun,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );

  Widget button(ontap) => Container(
    width: 150,
    height: 55,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: moonColor.withAlpha(40),
          offset: Offset(0, 6),
          blurRadius: 15,
        ),
      ],
      borderRadius: .circular(60),
      gradient: LinearGradient(
        begin: .topLeft,
        end: .bottomCenter,
        colors: [
          Color(0xFF806086), // 왼쪽 밝은 부분
          Color(0xFF3C1462), // 오른쪽 진한 보라
        ],
        stops: [0.0, 0.9],
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
              '결과 확인',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: nanun,
                fontWeight: .w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget cloud() => Stack(
    children: [
      Positioned(
        top: -20,
        left: 0,
        right: 0,
        child: SizedBox(
          height: 200,
          child: Transform.scale(scaleY: -1, child: Cloud()),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(height: 200, child: Cloud()),
      ),
    ],
  );
}
