import 'dart:ffi';
import 'dart:math';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/model/user.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../widget/base_text_filed.dart';

class BirthTimeEnter extends StatefulWidget {
  final PageController pageController;

  const BirthTimeEnter({super.key, required this.pageController});

  @override
  State<BirthTimeEnter> createState() => _BirthTimeEnterState();
}

class _BirthTimeEnterState extends State<BirthTimeEnter> {
  int _selectedIndex = 0;
  bool isAm = true;

  double size = 170;
  int H_angleIndex = UserController.user.value.birth.hour;
  int M_angleIndex = UserController.user.value.birth.minute ~/ 5;

  DateTime birthTime = UserController.user.value.birth;

  void changeHour(int number) {
    birthTime = DateTime(
      birthTime.year,
      birthTime.month,
      birthTime.day,
      number,
      birthTime.minute,
    );
    print(birthTime);
    H_angleIndex = number;
    _selectedIndex = 1;
    setState(() {});
  }

  void changeMinute(int minute, index) {
    birthTime = DateTime(
      birthTime.year,
      birthTime.month,
      birthTime.day,
      birthTime.hour,
      minute,
    );

    M_angleIndex = index;
    print(birthTime);
    UserController.user.value.birth = birthTime;
    setState(() {});

    final re = UserController.returnPageIndex;
    print(re);

    if (re != null) {
      UserController.returnPageIndex = null;
      widget.pageController.animateToPage(
        re,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 280,
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [timeState(), SizedBox(height: 40), clock()],
        ),
      ),
    );
  }

  Widget clock() => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      border: .all(color: Colors.white.withAlpha(170), width: 1.2),
      borderRadius: .circular(size),
    ),
    child: Stack(alignment: .center, children: [clockBody(), hourList()]),
  );

  Widget hourList() => SizedBox(
    width: size - 30,
    height: size - 30,
    child: Stack(
      clipBehavior: Clip.none,
      children: List.generate(12, (index) {
        final timeItem = _selectedIndex == 0
            ? hourItem(index)
            : minuteItem(index);

        return timeItem;
      }),
    ),
  );

  Widget hourItem(index) {
    final number = index == 0 ? 12 : index;
    final hour = int.tryParse(DateFormat('hh').format(birthTime));
    final selected = number == hour;

    return baseItem(index, () => changeHour(number), selected, '${number}');
  }

  Widget minuteItem(index) {
    final minute = index * 5;
    final min = int.tryParse(DateFormat('mm').format(birthTime));
    final selected = minute == min;

    return baseItem(
      index,
      () => changeMinute(minute, index),
      selected,
      '${minute}',
    );
  }

  Widget baseItem(index, ontap, selected, text) {
    final angel = -(pi / 2) + index * (2 * pi / 12);

    final x = (size / 2 - 17) * cos(angel);
    final y = (size / 2 - 17) * sin(angel);

    return Positioned(
      left: x + 54,
      top: y + 54,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: .circular(30),
          onTap: ontap,
          child: Container(
            width: 30,
            height: 30,
            alignment: .center,
            decoration: BoxDecoration(
              border: .all(
                color: selected
                    ? Colors.white.withAlpha(170)
                    : Colors.transparent,
                width: 1.2,
              ),
              borderRadius: .circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .w600,
                fontSize: 15,
                fontFamily: nanun,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clockBody() {
    final _angleIndex = _selectedIndex == 0 ? H_angleIndex : M_angleIndex;
    double clockAngle = -(pi / 2) + _angleIndex * (2 * pi / 12);

    return Stack(
      alignment: .center,
      children: [
        Container(
          width: size * 0.05,
          height: size * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: .circular(size * 0.05),
          ),
        ),
        Transform.rotate(
          angle: clockAngle,
          child: Container(
            width: size,
            height: size,
            alignment: .centerRight,
            child: Transform.translate(
              offset: Offset(-30, 0),
              child: Container(
                width: size / 2 - 30,
                height: 1,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget timeState() => Row(
    mainAxisAlignment: .center,
    spacing: 15,
    children: [showTime(), apToggle()],
  );

  apToggle() => ToggleButtons(
    constraints: BoxConstraints(maxHeight: 100, maxWidth: 55),
    borderRadius: .circular(16),
    borderColor: Colors.white.withAlpha(120),
    borderWidth: 1.2,
    selectedBorderColor: Colors.white,
    onPressed: (index) {
      isAm = index == 0;
      int hour = birthTime.hour;
      print(hour);
      print(isAm);
      if (isAm) {
        if (hour >= 12) {
          hour = hour - 12;
        }
      } else {
        if (hour < 12) {
          hour = hour + 12;
        } else {
          hour = 23;
        }
      }
      birthTime = DateTime(
        birthTime.year,
        birthTime.month,
        birthTime.day,
        hour,
        birthTime.minute,
      );
      H_angleIndex = hour;
      print(birthTime);
      setState(() {});
    },
    children: [toggleItem('AM', isAm), toggleItem('PM', !isAm)],
    direction: Axis.vertical,
    isSelected: [isAm, !isAm],
  );

  Widget toggleItem(text, isam) => Container(
    padding: .symmetric(horizontal: 12, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        color: isam ? Colors.white : Colors.white.withAlpha(120),
        fontFamily: nanun,
        fontSize: 15,
        fontWeight: .w700,
      ),
    ),
  );

  Widget showTime() {
    String hour = DateFormat('hh').format(birthTime);
    String minute = DateFormat('mm').format(birthTime);

    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .baseline,
      textBaseline: .alphabetic,
      spacing: 15,
      children: [
        baseTime('${hour}', 0),
        Text(':', style: TextStyle(color: Colors.white, fontSize: 40)),
        baseTime('${minute}', 1),
      ],
    );
  }

  Widget baseTime(text, select) {
    final selected = _selectedIndex == select;

    return GestureDetector(
      onTap: () {
        _selectedIndex = select;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: .symmetric(horizontal: selected ? 14 : 0, vertical: 6),
        decoration: BoxDecoration(
          border: .all(
            width: 1.2,
            color: selected ? Colors.white.withAlpha(100) : Colors.transparent,
          ),
          borderRadius: .circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: selected ? 32 : 30,
            color: selected ? Colors.white : Colors.white.withAlpha(100),
            fontWeight: .w700,
            fontFamily: nanun,
          ),
        ),
      ),
    );
  }
}
