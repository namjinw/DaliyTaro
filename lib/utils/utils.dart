import 'package:dailytaro/page/home.dart';
import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/userController.dart';

const noto = 'NotoSansKR';
const nanum = 'NaNum';
const background = [Color(0xff3c1361), Color(0xff260c3f)];
const buttonColor = [Color(0xff846679), Color(0xff3c1462)];
const stateButtonColor = Color(0xd3432066);

double sizew(context) => MediaQuery.sizeOf(context).width;

double sizeh(context) => MediaQuery.sizeOf(context).height;

void move(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) => false,
);

void checkDialog(context) => showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      backgroundColor: background.last,
      title: Center(child: Image.asset('assets/images/Daily Tarot.png', width: 100)),
      content: const Text(
        '정말 입력하신 정보로 하시겠습니까?',
        style: TextStyle(color: Colors.white, fontWeight: .w800, fontSize: 16),
      ),

      actions: [
        BaseWidget.dialogButton('취소', () {
          Navigator.pop(context);
        }),

        BaseWidget.dialogButton('확인', () {
          Navigator.pop(context);
          move(context, HomePage());
        }),
      ],
    );
  },
);

ShowSnackerBar(context, icon, text) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .w600,
                fontFamily: noto,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
