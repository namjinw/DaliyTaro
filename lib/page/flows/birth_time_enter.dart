import 'dart:math' as math;

import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../controller/userController.dart';
import '../../utils/utils.dart';

class BirthTimeEnter extends StatefulWidget {
  const BirthTimeEnter({super.key});

  @override
  State<BirthTimeEnter> createState() => _BirthTimeEnterState();
}

class _BirthTimeEnterState extends State<BirthTimeEnter> {
  DateTime birthTime = UserController.user.value.birth;

  bool timeChange = true;
  bool isAM = true;
  double size = 180;

  void onSelect(int value) {
    setState(() {
      if (timeChange) {
        int h = isAM ? (value == 12 ? 0 : value) : (value == 12 ? 12 : value + 12);
        birthTime = DateTime(birthTime.year, birthTime.month, birthTime.day, h, birthTime.minute);
        UserController.user.value.birth = birthTime;
      } else {
        birthTime = DateTime(birthTime.year, birthTime.month, birthTime.day, birthTime.hour, value);

        UserController.user.value.birth = birthTime;

        if (UserController.backIndex != null) {
          UserController.pageIndex.value = UserController.backIndex!;
          UserController.backIndex = null;
          FocusScope.of(context).unfocus();
          setState(() {});
          return;
        }

        UserController.pageIndex.value++;
      }
      print(birthTime);
    });
  }

  void updateAP() {

    int currentHour = birthTime.hour;
    int newHour = currentHour;

    if (isAM && currentHour >= 12) {
      newHour = currentHour - 12;
    } else if (!isAM && currentHour < 12) {
      newHour = currentHour + 12;
    }

    if (newHour != currentHour) birthTime = DateTime(birthTime.year, birthTime.month, birthTime.day, newHour, birthTime.minute);
    print(birthTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 45),
        Row(
          mainAxisAlignment: .center,
          children: [timePick(), const SizedBox(width: 15), toggle()],
        ),
        const SizedBox(height: 35),
        clock(),
      ],
    );
  }

  Widget clock() => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      border: .all(width: 1.5, color: Colors.white),
      shape: .circle,
    ),
    child: Stack(
      alignment: .center,
      children: [centerDot(8), picker(), numbers()],
    ),
  );

  Widget numbers() => Stack(
    alignment: .center,
    children: List.generate(12, (index) => baseNum(index)),
  );

  Widget baseNum(index) {
    final angle = -(math.pi / 2) + index * (math.pi * 2 / 12);

    final hour = index == 0 ? 12 : index;
    final minute = index * 5;
    final number = timeChange ? hour : minute;

    final selected = timeChange
        ? (hour == (birthTime.hour % 12 == 0 ? 12 : birthTime.hour % 12))
        : (minute == birthTime.minute);

    final x = (size / 2 - 17) * math.cos(angle);
    final y = (size / 2 - 17) * math.sin(angle);

    return Positioned(
      left: x + 71,
      top: y + 72,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: .circular(30),
          onTap: () => onSelect(number),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border: .all(
                width: 1,
                color: selected ? Colors.white : Colors.transparent,
              ),
              borderRadius: .circular(30),
            ),
            child: Center(
              child: Text(
                '${number}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget picker() {
    final double pickerAngle = timeChange
        ? (birthTime.hour % 12) / 12 + 0.25
        : (birthTime.minute / 60) + 0.25;

    final angle = (pickerAngle * 2 * math.pi);

    return SizedBox(
      width: size,
      height: size,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          alignment: .centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 31),
          child: Container(
            width: size / 2 - 32,
            height: 1.1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget centerDot(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: .circle, color: Colors.white),
  );

  Widget toggle() => ToggleButtons(
    splashColor: Colors.white.withAlpha(70),
    constraints: BoxConstraints(maxHeight: 25, maxWidth: 42),
    onPressed: (index) {
      isAM = index == 0;
      updateAP();
      setState(() {});
    },
    borderWidth: 1.3,
    borderColor: Colors.white.withAlpha(120),
    borderRadius: .circular(14),
    disabledColor: Colors.white,
    selectedBorderColor: Colors.white,
    direction: .vertical,
    children: [toggleItem('AM'), toggleItem('PM', isam: false)],
    isSelected: [isAM, !isAM],
  );

  Widget toggleItem(text, {isam = true}) => Container(
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: isam == isAM ? Colors.white : Colors.white.withAlpha(120),
          fontWeight: .w800,
          fontSize: 15,
        ),
      ),
    ),
  );

  Widget timePick() {
    String formatHour = DateFormat('hh').format(birthTime);
    String formatMinute = DateFormat('mm').format(birthTime);

    return Row(
      mainAxisAlignment: .center,
      spacing: 15,
      children: [
        formatItem(formatHour),
        Text(
          ':',
          style: TextStyle(
            color: Colors.white,
            fontWeight: .w800,
            fontSize: 32,
          ),
        ),
        formatItem(formatMinute, hour: false),
      ],
    );
  }

  Widget formatItem(text, {hour = true}) {
    final isHour = hour == timeChange;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: () {
          timeChange = hour;
          setState(() {});
        },
        child: AnimatedContainer(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isHour ? Colors.white : Colors.white.withAlpha(120),
                fontWeight: .w600,
                fontSize: 30,
              ),
            ),
          ),
          duration: Duration(milliseconds: 100),
          padding: .symmetric(horizontal: isHour ? 12 : 0, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: .circular(14),
            border: .all(
              color: isHour ? Colors.white.withAlpha(100) : Colors.transparent,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
