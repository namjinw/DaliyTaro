import 'package:dailytarget/controller/toast.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

import '../../controller/user_controller.dart';

class BuyBottomSheet extends StatefulWidget {
  const BuyBottomSheet({super.key});

  @override
  State<BuyBottomSheet> createState() => _BuyBottomSheetState();
}

class _BuyBottomSheetState extends State<BuyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: SizedBox(
          width: 150,
          child: Image.asset('assets/images/Daily Tarot.png', fit: .contain),
        ),
      ),
      content: content(),
      actions: [
        button(
          () {
            Navigator.pop(context, false);
          },
          '취소',
          false,
        ),
        button(
          () async {
            await UserController.addMoon(ToastController.SelectedMoon);
            Navigator.pop(context, true);
            ToastController.toast('달 ${ToastController.SelectedMoon}개가 충전 되었습니다!');
          },
          '결제하기',
          true,
        ),
      ],
      backgroundColor: background.first,
    );
  }

  Widget button(ontap, text, buy) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: ontap,
      borderRadius: .circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(
            color: buy ? Colors.yellow : Colors.white,
            fontWeight: .w600,
            fontSize: buy ? 16 : 14,
          ),
        ),
      ),
    ),
  );

  Widget content() => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .start,
    children: [
      Text(
        '정말로 달${ToastController.SelectedMoon}개를 충전하시겠습니까?',
        style: TextStyle(color: Colors.white, fontWeight: .w700, fontSize: 16),
      ),
      Text(
        '실제 계좌를 통해 결제됩니다.',
        style: TextStyle(
          color: Colors.white.withAlpha(180),
          fontWeight: .w800,
          fontSize: 14,
        ),
      ),
    ],
  );
}
