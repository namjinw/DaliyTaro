import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:flutter/material.dart';

import '../util/util.dart';

class TarotPage extends StatefulWidget {
  const TarotPage({super.key});

  @override
  State<TarotPage> createState() => _TarotPageState();
}

class _TarotPageState extends State<TarotPage> {
  final String selectedTarot = SoulController.type == TarotType.fruit
      ? '열매타로'
      : '인연 타로';
  final String tarotText = SoulController.type == TarotType.fruit
      ? '지금 생각하고 있는 일은 어떤 결과로 이어질까요?'
      : '생각하고 있는 그 사람과 인연이 될 수 잇을까요?';

  bool shuffleIn = false;
  bool shuffleOut = false;

  Future<void> shuffleClick() async {
    shuffleIn = !shuffleIn;
    setState(() {});
    
    Future.delayed(Duration(milliseconds: 100));

    shuffleOut = true;
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
          child: Stack(children: [cloud(), title(), fruit()]),
        ),
      ),
    );
  }

  Widget fruit() => Stack(children: [shuffle(), shuffleContent()]);

  Widget shuffleContent() => Align(
    alignment: .center,
    child: Container(
      height: 430,
      padding: .symmetric(horizontal: 55),
      child: shuffleCards(),
    ),
  );

  Widget shuffleCards() => Stack(
    children: [
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .topLeft),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center :  .topCenter),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .topRight),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .centerLeft),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .center),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .centerRight),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .bottomLeft),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .bottomCenter),
      shuffleCardItem(shuffleIn ? .center : !shuffleOut ? .center : .bottomRight),
    ],
  );

  Widget shuffleCardItem(Alignment align) => AnimatedAlign(
    duration: shuffleIn
        ? Duration(milliseconds: 350)
        : Duration(milliseconds: 500),
    curve: Curves.easeInOutCirc,
    alignment: align,
    child: SizedBox(
      width: 85,
      child: Image.asset('assets/images/tarot_card_back.png', fit: .contain),
    ),
  );

  Widget shuffle() => Positioned(
    left: 0,
    right: 0,
    bottom: 95,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        shuffleButton(() {
          shuffleClick();
        }, '셔플'),
      ],
    ),
  );

  Widget shuffleButton(ontap, text) => Center(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(50),
        onTap: ontap,
        child: Container(
          padding: .symmetric(horizontal: 34, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: .circular(50),
            color: Colors.white.withAlpha(15),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: .center,
              spacing: 5,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget title() => Positioned(
    left: 0,
    right: 0,
    top: 20,
    child: Column(
      children: [
        Image.asset('assets/images/graphic.png', width: 65),
        titleText(),
      ],
    ),
  );

  Widget titleText() => Column(
    children: [
      Text(
        '${selectedTarot}를 선택하셨네요.',
        style: TextStyle(
          color: Colors.white,
          fontFamily: nanun,
          fontWeight: .w700,
          fontSize: 16,
        ),
      ),
      Text(
        '신중하게 카드 1장을 선택해주세요.',
        style: TextStyle(
          color: Colors.white,
          fontFamily: nanun,
          fontWeight: .w700,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 8),
      Text(
        tarotText,
        style: TextStyle(
          color: Colors.white.withAlpha(180),
          fontWeight: .w700,
          fontSize: 12,
        ),
      ),
    ],
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
