import 'dart:math';

import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:dailytarget/page/widget/soul_card_show.dart';
import 'package:dailytarget/page/widget/soul_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../util/util.dart';

class SoulCardPage extends StatefulWidget {
  const SoulCardPage({super.key});

  @override
  State<SoulCardPage> createState() => _SoulCardPageState();
}

class _SoulCardPageState extends State<SoulCardPage> {
  int soulNumber(DateTime time) {
    int sum = time.year + time.month + time.day;
    print(time);
    print(sum);

    while (sum >= 10) {
      sum = digitSum(sum);
    }

    return sum;
  }

  int digitSum(int n) {
    int total = 0;

    while (n > 0) {
      total += n % 10;
      n ~/= 10;
    }
    print(total);

    return total;
  }

  Future<void> cardShow() async {
    if (SoulController.birthText == null) {
      ShowSnacker(context, Icons.calendar_today, '생년월일을 먼저 입력해주세요!');
      return;
    }
    if (UserController.user.value.moon < 10) {
      ShowSnacker(context, Icons.motion_photos_on, '보유하신 달의 개수가 부족합니다!');
      return;
    }
    UserController.addMoon(-10);
    final soulNum = soulNumber(SoulController.birth);
    SoulController.SearchCard(soulNum);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SoulCardShowDialog(),
      barrierColor: Colors.black,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      extendBodyBehindAppBar: true,
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
          child: Stack(children: [topCloud(), bottomCloud(), content()]),
        ),
      ),
    );
  }

  Widget content() => Positioned(
    top: 70,
    left: 0,
    right: 0,
    child: Column(
      children: [
        title(),
        SizedBox(height: 25),
        text(),
        SizedBox(height: 50),
        birthPicker(),
        SizedBox(height: 45),
        search(),
      ],
    ),
  );

  Widget search() =>
      Column(children: [searchButton(), SizedBox(height: 15), searchText()]);

  Widget searchText() => Column(
    children: [
      Text(
        '소울카드에 사용하는 정보는',
        style: TextStyle(
          color: Colors.white.withAlpha(100),
          fontSize: 10,
          fontWeight: .w800,
        ),
      ),

      Text(
        '카드 조합 용도 외에 사용되지 않습니다.',
        style: TextStyle(
          color: Colors.white.withAlpha(100),
          fontSize: 10,
          fontWeight: .w800,
        ),
      ),
    ],
  );

  Widget searchButton() => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: cardShow,
      borderRadius: .circular(55),
      child: Container(
        width: 270,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: .circular(55),
          gradient: LinearGradient(colors: buttonColor, stops: [0.0, 0.7, 1.0]),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Image.asset('assets/images/moon.png', width: 32),
            SizedBox(width: 10),
            Text(
              '달 10개로 소울카드 찾기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: .w900,
                fontFamily: nanun,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget birthPicker() {
    final picked = SoulController.birthText == null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(509),
        onTap: () async {
          final bool pick = await showDialog(
            context: context,
            builder: (context) => SoulPicker(),
          );

          if (pick) {
            SoulController.birthText = DateFormat(
              'yyyy.MM.dd',
            ).format(SoulController.birth);
            setState(() {});
          }
        },
        child: Container(
          width: 220,
          height: 50,
          padding: .only(left: 8),
          decoration: BoxDecoration(
            borderRadius: .circular(55),
            border: .all(color: Colors.white.withAlpha(150), width: 1.5),
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              Text(
                picked ? '생년월일을 입력해주세요' : SoulController.birthText!,
                style: TextStyle(
                  color: Colors.white.withAlpha(150),
                  fontSize: picked ? 14 : 18,
                  fontWeight: .w600,
                ),
              ),

              picked
                  ? Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(
                        'assets/icons/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withAlpha(190),
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget text() {
    TextStyle defaultStyle = TextStyle(
      fontWeight: .w800,
      fontSize: 12,
      height: 2.4,
      color: Colors.white.withAlpha(220),
    );

    TextStyle yelloStyle = TextStyle(
      fontWeight: .w800,
      fontSize: 12,
      height: 2.4,
      color: Colors.yellow.shade700,
    );

    return Text.rich(
      textAlign: .center,
      TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(text: '소울 넘버', style: yelloStyle),
          TextSpan(
            text:
                '는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n 이 소울 넘버에 해당하는\n 메이저 아르카나 타로 카드가 바로 ',
          ),
          TextSpan(text: '소울 카드', style: yelloStyle),
          TextSpan(
            text: '이며,\n이는 당신의 타고난 성격, 기질\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ',
          ),
          TextSpan(text: '영혼의 번호', style: yelloStyle),
          TextSpan(text: '이고,\n소울 카드는 그 번호가 의미하는\n'),
          TextSpan(text: '영혼의 본질', style: yelloStyle),
          TextSpan(text: '을 보여주는 상징인 셈입니다.'),
        ],
      ),
    );
  }

  Widget title() => Column(
    children: [
      Image.asset('assets/images/graphic.png', width: 60),
      Transform.translate(
        offset: Offset(0, -10),
        child: Text(
          '나의 생일로 알아보는 소울카드',
          style: TextStyle(
            color: Colors.white,
            fontFamily: nanun,
            fontWeight: .w800,
            fontSize: 19,
          ),
        ),
      ),
    ],
  );

  Widget topCloud() => Positioned(
    top: -20,
    left: 0,
    right: 0,
    child: SizedBox(
      height: 200,
      child: Transform.scale(scaleY: -1, child: Cloud()),
    ),
  );

  Widget bottomCloud() => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: SizedBox(height: 200, child: Cloud()),
  );

  AppBar appBar() => AppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 60,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: SvgPicture.asset(
        'assets/icons/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
        width: 25,
      ),
    ),
  );
}
