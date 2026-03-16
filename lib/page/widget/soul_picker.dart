import 'package:dailytarget/controller/soul.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';

class SoulPicker extends StatefulWidget {
  const SoulPicker({super.key});

  @override
  State<SoulPicker> createState() => _SoulPickerState();
}

class _SoulPickerState extends State<SoulPicker> {
  final now = DateTime.now();

  int days(DateTime month) {
    return DateTime(month.year, month.month + 1, 0).day;
  }

  void timeCheck() {

    final today = DateTime.now();

    if (SoulController.birth.isAfter(today)) {
      myDialog(context, '생년월일은 오늘 날자보다 이전 날짜여야만 합니다!');
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: background,
            begin: .topLeft,
            end: .bottomRight,
            stops: [0.0, 0.6],
          ),
          borderRadius: .circular(16),
        ),
        width: sizew(context),
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        height: 300,
        child: content(),
      ),
    );
  }

  Widget content() => Column(
    crossAxisAlignment: .start,
    spacing: 10,
    children: [
      Text(
        '생년월일 선택',
        style: TextStyle(color: Colors.white, fontWeight: .w600, fontSize: 20),
      ),
      line(),
      SizedBox(height: 160, child: picker()),
      line(),
      Expanded(child: submit()),
    ],
  );

  Widget submit() => Row(
    mainAxisAlignment: .end,
    children: [
      button(() {
        Navigator.pop(context);
      }, '취소'),
      button(() {
        timeCheck();
      }, '선택'),
    ],
  );

  Widget button(ontap, text) => TextButton(
    onPressed: ontap,
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: .w600, fontSize: 18),
    ),
  );

  Widget picker() => Stack(alignment: .center, children: [pickers()]);

  Widget pickers() => Row(
    children: [
      Expanded(child: yPicker()),
      Expanded(child: mPicker()),
      Expanded(child: dPicker()),
    ],
  );

  Widget overlay() => SizedBox(
    width: 15,
    height: 60,
    child: Column(
      mainAxisAlignment: .spaceBetween,
      children: [line(size: 3, alpha: 130), line(size: 3, alpha: 130)],
    ),
  );

  Widget yPicker() => basePicker(
    ListWheelChildBuilderDelegate(
      childCount: 100,
      builder: (context, index) {
        final year = now.year - index;
        final bool Selected = year == SoulController.birth.year;

        return baseItem(
          '$year',
          Selected ? Colors.white : Colors.white.withAlpha(150),
        );
      },
    ),
    (int value) {
      final int year = now.year - value;
      SoulController.birth = SoulController.birth.copyWith(year: year);
      print(SoulController.birth);
      setState(() {});
    },
  );

  Widget mPicker() => basePicker(
    ListWheelChildBuilderDelegate(
      childCount: 12,
      builder: (context, index) {
        final month = index + 1;
        final formatText = month.toString().padLeft(2, '0');
        final bool Selected = month == SoulController.birth.month;

        return baseItem(
          '${formatText}',
          Selected ? Colors.white : Colors.white.withAlpha(150),
        );
      },
    ),
    (int value) {
      final int month = value + 1;
      SoulController.birth = SoulController.birth.copyWith(month: month);
      print(SoulController.birth);
      setState(() {});
    },
  );

  Widget dPicker() => basePicker(
    ListWheelChildBuilderDelegate(
      childCount: days(SoulController.birth),
      builder: (context, index) {
        final day = index + 1;
        final formatText = day.toString().padLeft(2, '0');
        final bool Selected = day == SoulController.birth.day;

        return baseItem(
          '${formatText}',
          Selected ? Colors.white : Colors.white.withAlpha(150),
        );
      },
    ),
    (int value) {
      SoulController.birth = SoulController.birth.copyWith(day: (value + 1));
      print(SoulController.birth);
      setState(() {});
    },
  );

  Widget baseItem(text, color) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: .w600, fontSize: 22),
      ),
    );
  }

  Widget basePicker(child, onChange) => Stack(
    alignment: .center,
    children: [
      ListWheelScrollView.useDelegate(
        childDelegate: child,
        physics: FixedExtentScrollPhysics(),
        itemExtent: 60,
        magnification: 1,
        perspective: 0.00001,
        useMagnifier: true,
        onSelectedItemChanged: onChange,
      ),
      IgnorePointer(ignoring: true, child: Center(child: overlay())),
    ],
  );

  Widget line({double size = 1, alpha = 60}) =>
      Container(height: size, color: Colors.white.withAlpha(alpha));
}
