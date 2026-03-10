import 'dart:ffi';

import 'package:dailytarget/controller/user_controller.dart';
import 'package:dailytarget/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/base_text_filed.dart';

class BirthEnter extends StatefulWidget {
  final PageController pageController;

  const BirthEnter({super.key, required this.pageController});

  @override
  State<BirthEnter> createState() => _BirthEnterState();
}

class _BirthEnterState extends State<BirthEnter> {
  final now = DateTime.now();
  DateTime birth = UserController.user.value.birth;

  List<DateTime> thisMonth(DateTime nowMonth) {
    final first = DateTime(nowMonth.year, nowMonth.month, 1);
    final last = DateTime(nowMonth.year, nowMonth.month + 1, 0);

    final week = first.weekday % 7; // 시작 일 요일 계산 왜? => 그 뒤만큼 채우기 위해
    final currentDay = last.day;
    final allDay = 42 - (week + currentDay); // 전월 + 현월

    final List<DateTime> dates = [];

    // 전월
    for (int i = week; i > 0; i--) {
      dates.add(first.subtract(Duration(days: i)));
    }

    // 현월
    for (int i = 1; i <= currentDay; i++) {
      dates.add(DateTime(nowMonth.year, nowMonth.month, i));
    }

    // 후월
    for (int i = 1; i <= allDay; i++) {
      dates.add(DateTime(nowMonth.year, nowMonth.month + 1, i));
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 280,
      child: Center(child: calender()),
    );
  }

  Widget calender() {
    return Column(
      crossAxisAlignment: .center,
      children: [yearMonth(), SizedBox(height: 10), days()],
    );
  }

  Widget yearMonth() => Row(
    mainAxisAlignment: .center,
    children: [
      yearList(),
      Text(
        '.',
        style: TextStyle(
          color: Colors.white,
          fontWeight: .w600,
          fontFamily: nanun,
          fontSize: 26,
        ),
      ),
      monthList(),
    ],
  );

  Widget yearList() => list(
    '${birth.year}',
    (value) {
      birth = DateTime(value, birth.month, birth.day);
      setState(() {});
    },
    List.generate(
      100,
      (index) => PopupMenuItem(
        child: Center(child: item(now.year - index)),
        value: now.year - index,
      ),
    ),
  );

  Widget monthList() => list(
    '${birth.month}',
    (value) {
      birth = DateTime(birth.year, value, birth.day);
      setState(() {});
    },
    List.generate(
      12,
      (index) => PopupMenuItem(
        child: Center(child: item(index + 1)),
        value: index + 1,
      ),
    ),
  );

  Widget list(text, onChange, generate) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      child: PopupMenuButton(
        onSelected: onChange,
        constraints: BoxConstraints(maxHeight: 300, maxWidth: 80),
        offset: Offset(0, 35),
        color: buttonColor.last,
        itemBuilder: (context) {
          return generate;
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .w600,
            fontFamily: nanun,
            fontSize: 26,
          ),
        ),
      ),
    ),
  );

  Widget item(text) => GestureDetector(
    child: Text(
      '${text}',
      style: TextStyle(
        color: Colors.white,
        fontWeight: .w600,
        fontFamily: nanun,
        fontSize: 20,
      ),
    ),
  );

  Widget days() {
    List<DateTime> selectBirth = thisMonth(birth);

    return SizedBox(
      width: sizew(context) * 0.8,
      height: 300,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        children: List.generate(
          selectBirth.length,
          (index) => dayItem(selectBirth[index].day, selectBirth[index]),
        ),
      ),
    );
  }

  Widget dayItem(index, DateTime selectBirth) {
    final selectedMonth = birth.month == selectBirth.month
        ? Colors.white
        : Colors.white.withAlpha(100);

    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            birth = DateTime(
              selectBirth.year,
              selectBirth.month,
              selectBirth.day,
              UserController.user.value.birth.hour,
              UserController.user.value.birth.minute,
            );
            UserController.user.value.birth = birth;
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
          },
          borderRadius: .circular(30),
          child: Center(
            child: Text(
              '${index}',
              style: TextStyle(
                fontSize: 18,
                color: selectedMonth,
                fontFamily: nanun,
                fontWeight: .w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
