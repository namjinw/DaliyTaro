import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tarotImage = ['love_tarot.png', 'fruit_tarot.png'];
  final tarotText = ['인연타로', '열매타로'];
  final tarotSubtext1 = ['지금은 힘들지만 그래도,', '지금 생각하고 있는 일은'];
  final tarotSubtext2 = ['그 사람과 인연이 될 수 있을까?', '어떤 결과로 이어질까?'];

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                logo(),
                soulCardList(),
                SizedBox(height: 40),
                tarotList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tarotList() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          'Daily Tarot List',
          style: TextStyle(
            color: Colors.white,
            fontFamily: nanun,
            fontWeight: .w800,
            fontSize: 21,
          ),
        ),

        SizedBox(
          width: sizew(context),
          height: 200,
          child: ListView.separated(
            itemCount: 2,
            clipBehavior: .none,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 15),
            itemBuilder: (context, index) => listItem(index),
          ),
        ),
      ],
    ),
  );

  Widget listItem(index) => Container(
    child: ClipRRect(
      borderRadius: .circular(12),
      child: Stack(
        children: [
          Image.asset('assets/images/${tarotImage[index]}'),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  '${tarotText[index]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: .w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 3,),
                Text(
                  '${tarotSubtext1[index]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: .w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${tarotSubtext2[index]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: .w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget soulCardList() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Column(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text(
          'Daily Tarot Soul Card',
          style: TextStyle(
            color: Colors.white,
            fontFamily: nanun,
            fontWeight: .w700,
            fontSize: 21,
          ),
        ),
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: .circular(20),
            boxShadow: [BoxShadow(color: Color(0xff4d3572), blurRadius: 20)],
          ),
          child: ClipRRect(
            borderRadius: .circular(20),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/daily_tarot_soul_card.png',
                  fit: BoxFit.contain,
                ),
                soulCardText(),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget soulCardText() => Positioned(
    bottom: 20,
    right: 30,
    child: Column(
      crossAxisAlignment: .end,
      children: [
        Text(
          'Soul Card',
          style: TextStyle(
            color: Colors.white,
            fontFamily: nanun,
            fontWeight: .w700,
            fontSize: 18,
          ),
        ),
        Text(
          '운명적인 나만의 데일리 카드',
          style: TextStyle(
            letterSpacing: 0.1,
            color: Colors.white.withAlpha(230),
            fontFamily: nanun,
            fontWeight: .w700,
            fontSize: 13,
          ),
        ),
        Text(
          '매일 하루를 카운셀팅 받으세요.',
          style: TextStyle(
            letterSpacing: 0.1,
            color: Colors.white.withAlpha(230),
            fontFamily: nanun,
            fontWeight: .w700,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );

  Widget logo() => Column(
    children: [
      Image.asset('assets/images/Daily Tarot.png', width: 200),
      Transform.translate(
        offset: Offset(0, -15),
        child: Image.asset('assets/images/graphic.png', width: 60),
      ),
    ],
  );
}
