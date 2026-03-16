import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/controller/toast.dart';
import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/page/moon_shop.dart';
import 'package:dailytarget/page/soul_card.dart';
import 'package:dailytarget/page/tarot.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = UserController.user.value;
  final tarotImage = ['love_tarot.png', 'fruit_tarot.png'];
  final tarotText = ['인연타로', '열매타로'];
  final tarotSubtext1 = ['지금은 힘들지만 그래도,', '지금 생각하고 있는 일은'];
  final tarotSubtext2 = ['그 사람과 인연이 될 수 있을까?', '어떤 결과로 이어질까?'];
  final tarotType = [TarotType.fruit, TarotType.love];

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
          child: Stack(children: [homeScroll(), moonCount()]),
        ),
      ),
    );
  }

  Widget moonCount() => Positioned(
    top: 15,
    right: 20,
    child: ValueListenableBuilder(
      valueListenable: UserController.user,
      builder: (context, value, child) => GestureDetector(
        onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MoonShop()),
          (route) => true,
        ),
        child: Row(
          mainAxisSize: .min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: .circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xfffcf38b).withAlpha(40),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Image.asset('assets/images/moon.png', width: 35),
            ),
            Text(
              '${value.moon}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: .w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget homeScroll() => SingleChildScrollView(
    physics: RangeMaintainingScrollPhysics(),
    child: Stack(
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
        Column(
          children: [
            SizedBox(height: 80),
            logo(),
            soulCardList(),
            SizedBox(height: 40),
            tarotList(),
            SizedBox(height: 30),
            master(),
            SizedBox(height: 100),
          ],
        ),
      ],
    ),
  );

  Widget master() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Daily Master',
          style: TextStyle(
            color: Colors.white,
            fontFamily: nanun,
            fontWeight: .w800,
            fontSize: 21,
          ),
        ),

        SizedBox(height: 15),

        Container(
          width: sizew(context),
          height: 220,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: buttonColor.first.withAlpha(40), blurRadius: 15),
            ],
          ),
          child: ClipRRect(
            borderRadius: .circular(18),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/daily_master.png',
                    fit: .contain,
                  ),
                ),
                masterText(),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: .circular(15),
                      onTap: () async {
                        ToastController.openWeb(
                          'https://ko.wikipedia.org/wiki/타로',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget masterText() => Positioned(
    left: 20,
    top: 25,
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '당신만을 위한 상담',
          style: TextStyle(
            color: Colors.white,
            fontWeight: .w800,
            fontFamily: nanun,
            fontSize: 21,
          ),
        ),

        Text(
          '당신을 위해 모인 \'데일리 마스터\'와',
          style: TextStyle(
            color: Colors.white.withAlpha(210),
            fontWeight: .w600,
            fontFamily: nanun,
            fontSize: 17,
          ),
        ),

        Text(
          '직접 이야기를 나누어 보세요.',
          style: TextStyle(
            color: Colors.white.withAlpha(210),
            fontWeight: .w600,
            fontFamily: nanun,
            fontSize: 17,
          ),
        ),
      ],
    ),
  );

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
            itemBuilder: (context, index) => listItem(index, tarotType[index]),
          ),
        ),
      ],
    ),
  );

  Widget listItem(index, type) => Container(
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
                SizedBox(height: 3),
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
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  SoulController.type = type;
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TarotPage()),
                  );
                },
              ),
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
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SoulCardPage()),
                        (route) => true,
                      ),
                    ),
                  ),
                ),
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
