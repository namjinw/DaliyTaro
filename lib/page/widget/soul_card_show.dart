import 'dart:math' as math;

import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/page/home.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SoulCardShowDialog extends StatefulWidget {
  const SoulCardShowDialog({super.key});

  @override
  State<SoulCardShowDialog> createState() => _SoulCardShowDialogState();
}

class _SoulCardShowDialogState extends State<SoulCardShowDialog> {
  final cardInfo = SoulController.selectedCard;
  final birth = SoulController.birth;
  bool change = false;
  double _angle = 0.0;

  String formatText(String text) {
    final words = text.split(' ');
    // 문장 쪼개서 list로
    final lines = [];
    var current = '';
    // current는 한 문장이다.

    for (final word in words) {
      // 단어 모든 길이 만큼
      if (current.isEmpty) {
        // 문장이 비었다면 첫 단어로
        current = word;
      } else {
        // 아니면 단어 추가
        current += ' $word';
      }
      if (word.endsWith('.') || current.length > 20) {
        // 만약 줄 내림 단어를 포함 한다면
        lines.add(current.trim()); // 배열로 추가 + 다시 공백으로 만들기
        current = '';
      }
    }

    if (current.isNotEmpty) lines.add(current); //

    return lines.join('\n');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 1));

      change = true;
      _angle = math.pi * 2;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: .only(left: 20, top: 10),
      child: Stack(children: [card(), cardTitle(), cardContent()]),
    );
  }

  Widget cardContent() => AnimatedOpacity(
    opacity: change ? 1 : 0,
    duration: Duration(milliseconds: 200),
    child: Stack(children: [section(), cardDetail(), close()]),
  );

  Widget close() => Positioned(
    left: 0,
    right: 0,
    bottom: 55,
    child: Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            SoulController.birthText = null;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
            setState(() {});
          },
          borderRadius: .circular(50),
          child: closeContent(),
        ),
      ),
    ),
  );

  Widget closeContent() => Container(
    width: 50,
    height: 50,
    padding: .all(10),
    decoration: BoxDecoration(
      border: .all(width: 1.5, color: Colors.white.withAlpha(80)),
      borderRadius: .circular(50),
    ),
    child: Center(child: Stack(children: [line(0.75), line(-0.75)])),
  );

  Widget line(double angle) => Transform.rotate(
    angle: angle,
    child: Container(height: 1, color: Colors.white.withAlpha(200)),
  );

  Widget cardDetail() => Positioned(
    top: 210,
    left: 5,
    right: 5,
    child: Text(
      '${formatText(cardInfo!.storytelling)}',
      textAlign: .center,
      style: TextStyle(
        color: Colors.white,
        fontFamily: nanun,
        fontWeight: .w800,
        fontSize: 15,
        height: 2,
      ),
    ),
  );

  Widget section() => Positioned(
    left: 120,
    right: 0,
    child: Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      children: [
        Image.asset('assets/images/graphic.png', width: 65),
        Transform.translate(offset: Offset(10, -10), child: sectionText()),
      ],
    ),
  );

  Widget sectionText() => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        '${birth.year}년 ${birth.month}월 ${birth.day}일생.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: .w700,
          fontFamily: nanun,
        ),
      ),
      SizedBox(height: 20),
      Text(
        '당신의 소울카드는',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: .w700,
          fontFamily: nanun,
        ),
      ),
      SizedBox(height: 15),
      Text(
        '${cardInfo!.number}번 ${cardInfo!.name} 입니다.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: .w700,
          fontFamily: nanun,
        ),
      ),
    ],
  );

  Widget cardTitle() => AnimatedOpacity(
    opacity: !change ? 1 : 0,
    duration: Duration(milliseconds: 350),
    child: Stack(
      children: [
        Align(
          alignment: .topCenter,
          child: Column(
            children: [
              Image.asset('assets/images/graphic.png', width: 65),
              Text(
                '${cardInfo!.number}번 ${cardInfo!.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: nanun,
                  fontWeight: .w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget card() => AnimatedAlign(
    duration: Duration(milliseconds: 700),
    alignment: !change ? .center : .topLeft,
    curve: Curves.easeOut,
    child: AnimatedContainer(
      width: !change ? 210 : 115,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      child: ClipRRect(
        borderRadius: .circular(16),
        child: TweenAnimationBuilder(
          builder: (context, value, child) => Transform(
            alignment: .center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(value),
            child: Image.asset('assets/images/tarot_cards/${cardInfo!.image}'),
          ),
          duration: Duration(milliseconds: 700),
          tween: Tween<double>(begin: 0, end: _angle),
          curve: Curves.easeOut,
        ),
      ),
    ),
  );
}
