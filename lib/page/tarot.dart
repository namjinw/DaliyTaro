import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/model/soul.dart';
import 'package:dailytarget/page/card.dart';
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
      : '생각하고 있는 그 사람과 인연이 될 수 있을까요?';

  bool shuffleOn = false;
  bool ignore = false;

  List<Alignment> shufflePosition = [
    .topLeft,
    .topCenter,
    .topRight,
    .centerLeft,
    .center,
    .centerRight,
    .bottomLeft,
    .bottomCenter,
    .bottomRight,
  ];

  late List<Alignment> currentPosition;

  late List<int> fruitCards;
  final PageController _pageController = PageController(
    initialPage: 4,
    viewportFraction: 0.45,
  );

  int? selectIndex;

  Future<void> shuffleClick() async {
    currentPosition = List.generate(currentPosition.length, (_) => .center);
    setState(() {});

    await Future.delayed(Duration(milliseconds: 600));
    shuffleOn = true;
    ignore = true;
    setState(() {});

    for (int i = 0; i < currentPosition.length; i++) {
      currentPosition[i] = shufflePosition[i];
      setState(() {});
      await Future.delayed(Duration(milliseconds: 300));
    }
    shuffleOn = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    List<int> fruitList = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    fruitList.shuffle();

    fruitCards = fruitList;

    currentPosition = shufflePosition;
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
              title(),
              SoulController.type == TarotType.fruit ? fruit() : love(),
            ],
          ),
        ),
      ),
    );
  }

  Widget love() => Stack(children: [loveTitle(), loveCards()]);

  Widget loveCards() => Positioned(
    left: 0,
    right: 0,
    bottom: 15,
    child: SizedBox(
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: SizedBox(
          width: 700,
          child: Stack(
            children: List.generate(
              fruitCards.length,
              (index) => loveItem(index.toDouble(), fruitCards[index]),
            ),
          ),
        ),
      ),
    ),
  );

  Widget loveItem(double index, loves) => AnimatedPositioned(
    duration: Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
    left: index * 70,
    bottom: -(index - 4).abs() * 12 + (selectIndex == loves ? 35 : 0),
    child: Hero(
      tag: loves,
      child: GestureDetector(
        onTap: () {
          if (selectIndex == loves) {
            SoulController.loveNum = loves;
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CardPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
              ),
                  (route) => false,
            );
          }

          selectIndex = loves;
          setState(() {});
        },
        child: Center(
          child: Transform.translate(
            offset: Offset(0, 0),
            child: Transform.rotate(
              angle: (index - 4) * 0.08,
              child: Container(
                alignment: .bottomCenter,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 10,
                      offset: Offset(-8, 2),
                    ),
                  ],
                ),
                width: 150,
                child: Image.asset('assets/images/tarot_card_back.png'),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  loveTitle() => Center(
    child: Text(
      '좌우로 스크롤하여\n카드 한 장을 골라보세요!',
      textAlign: .center,
      style: TextStyle(
        color: Colors.white.withAlpha(200),
        fontSize: 16,
        fontWeight: .w500,
      ),
    ),
  );

  Widget fruit() => Stack(children: [shuffle(), shuffleContent()]);

  Widget shuffleContent() => Align(
    alignment: .center,
    child: Container(
      height: 430,
      padding: .symmetric(horizontal: 55),
      child: shuffleCards(),
    ),
  );

  Widget shuffleCards() => IgnorePointer(
    ignoring: ignore ? false : true,
    child: Stack(
      children: List.generate(
        currentPosition.length,
        (index) => shuffleCardItem(currentPosition[index], fruitCards[index]),
      ),
    ),
  );

  Widget shuffleCardItem(Alignment align, int fruit) => AnimatedAlign(
    duration: shuffleOn
        ? Duration(milliseconds: 200)
        : Duration(milliseconds: 500),
    curve: shuffleOn ? Curves.easeInOutCirc : Curves.easeOutCubic,
    alignment: align,
    child: GestureDetector(
      onTap: () {
        SoulController.selectedNum = fruit;
        print(SoulController.selectedNum);
        print(SoulController.fruitCard!.length);
        setState(() {});
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => CardPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
          (route) => false,
        );
      },
      child: SizedBox(
        width: 85,
        child: Hero(
          tag: fruit,
          child: Image.asset(
            'assets/images/tarot_card_back.png',
            fit: .contain,
          ),
        ),
      ),
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
    child: IgnorePointer(
      ignoring: ignore ? true : false,
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
    ),
  );

  Widget title() => Positioned(
    left: 0,
    right: 0,
    top: SoulController.type == TarotType.love ? 60 : 20,
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
