import 'package:dailytarget/controller/toast.dart';
import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/page/widget/buy_bottom_sheet.dart';
import 'package:dailytarget/page/widget/cloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../util/util.dart';

class MoonShop extends StatefulWidget {
  const MoonShop({super.key});

  @override
  State<MoonShop> createState() => _MoonShopState();
}

class _MoonShopState extends State<MoonShop> {
  final user = UserController.user.value;

  final count = [25, 50, 75, 100, 200, 350];
  final discount = [750, 2600, 4750, 8000, 17000, 32500];
  final price = [5500, 9900, 14000, 17000, 33000, 55000];

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
          child: Stack(children: [topCloud(), bottomCloud(), moonBuy()]),
        ),
      ),
    );
  }

  Widget moonBuy() => Positioned(
    left: 0,
    right: 0,
    top: 60,
    child: Column(
      children: [
        title(),
        SizedBox(height: 20),
        moonCount(),
        SizedBox(height: 20),
        moonBuyList(),
      ],
    ),
  );

  Widget moonBuyList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: List.generate(11, (index) {
          if (index.isOdd) {
            return Container(height: 1, color: Colors.white.withAlpha(50));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: buyItem(index ~/ 2),
          );
        }),
      ),
    );
  }

  Widget buyItem(index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          ToastController.SelectedMoon = count[index];
          final buy = await showDialog(context: context, builder: (context) => BuyBottomSheet(),);
          if (buy) setState(() {});
        },
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            buyLeft(index),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '${NumberFormat('#,###').format(price[index])}원',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: .w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buyLeft(index) => Row(
    children: [
      moon(index),
      SizedBox(width: 10),
      Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            '달 ${count[index]}개',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: .w600,
            ),
          ),
          Text(
            '약 ${NumberFormat('#,###').format(discount[index])}원 할인',
            style: TextStyle(
              color: Colors.yellow.shade600,
              fontSize: 13,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    ],
  );

  Widget moon(index) => Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: .circular(30),
      boxShadow: [
        BoxShadow(color: Color(0xfffbf3bc).withAlpha(50), blurRadius: 20),
      ],
    ),
    child: Stack(
      children: [
        subMoon(0, 18, 30, index >= 2),
        subMoon(5, 5, 12, index >= 4),
        Image.asset('assets/images/moon.png', fit: .contain),
      ],
    ),
  );

  Widget subMoon(double right, double bottom, double size, bool show) =>
      Positioned(
        right: right,
        bottom: bottom,
        child: Opacity(
          opacity: show ? 1 : 0,
          child: SizedBox(
            width: size,
            child: Image.asset('assets/images/moon.png', fit: .contain),
          ),
        ),
      );

  Widget title() => Column(
    children: [
      Image.asset('assets/images/graphic.png', width: 65),
      Transform.translate(
        offset: Offset(0, -10),
        child: Text(
          '달 충전',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: nanun,
            fontWeight: .w800,
          ),
        ),
      ),
    ],
  );

  Widget moonCount() => Column(
    children: [
      Text(
        '현재 보유중인 달',
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: .w600),
      ),
      moonState(),
    ],
  );

  Widget moonState() => ValueListenableBuilder(
    valueListenable: UserController.user,
    builder: (context, value, child) =>  Row(
      mainAxisSize: .min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: .circular(30),
            boxShadow: [
              BoxShadow(color: Color(0xfffcf38b).withAlpha(40), blurRadius: 10),
            ],
          ),
          child: Image.asset('assets/images/moon.png', width: 35),
        ),
        SizedBox(width: 5),
        Text(
          '${value.moon}',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: .w800),
        ),
      ],
    ),
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
