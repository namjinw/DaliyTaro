import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controller/userController.dart';
import '../../utils/utils.dart';

class BirthEnter extends StatefulWidget {
  const BirthEnter({super.key});

  @override
  State<BirthEnter> createState() => _BirthEnterState();
}

class _BirthEnterState extends State<BirthEnter> {
  DateTime birth = UserController.user.value.birth;
  final now = DateTime.now();

  List<DateTime> getDate(DateTime value) {
    final first = DateTime(value.year, value.month, 1);
    final last = DateTime(value.year, value.month + 1, 0);

    final nowDay = last.day;
    print(nowDay);
    final week = first.weekday % 7;
    final nextDay = 42 - (nowDay + week);

    final List<DateTime> date = [];

    List.generate(
      week,
      (index) => date.add(first.subtract(Duration(days: week - index))),
    );
    List.generate(
      nowDay,
      (index) => date.add(DateTime(value.year, value.month, index + 1)),
    );
    List.generate(
      nextDay,
          (index) => date.add(DateTime(value.year, value.month + 1, index + 1)),
    );
    return date;
  }

  void next(DateTime day) {
    birth = day;
    UserController.user.value.birth = birth;

    if (UserController.backIndex != null) {
      UserController.pageIndex.value = UserController.backIndex!;
      UserController.backIndex = null;
      FocusScope.of(context).unfocus();
      setState(() {});
      return;
    }

    UserController.pageIndex.value++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [const SizedBox(height: 130), birthPicker()],
    );
  }

  Widget birthPicker() => Column(
    children: [
      yb(),
      const SizedBox(height: 10,),
      calender(),
    ],
  );

  Widget calender() {
    final days = getDate(birth);

    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.zero,
        itemCount: days.length,
        itemBuilder: (context, index) {
          return dayItem(days[index]);
        },
      ),
    );
  }

  Widget dayItem(DateTime day) {

    final isMonth = day.month == birth.month;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: .circular(30),
        onTap: () => next(day),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              color: isMonth ? Colors.white : Colors.white.withAlpha(50),
              fontSize: 18,
              fontWeight: .w800,
            ),
          ),
        ),
      ),
    );
  }

  Widget yb() => Row(
    mainAxisAlignment: .center,
    children: [yearPicker('${birth.year}.'), monthPicker('${birth.month}')],
  );

  Widget monthPicker(text) => popUp(
    text,
    List.generate(12, (index) {
      return popUpItem('${index + 1}', index + 1);
    }),
    20,
    (value) {
      birth = DateTime(birth.year, value, birth.day, birth.hour);
      print(birth);
      setState(() {});
    },
  );

  Widget yearPicker(text) => popUp(
    text,
    List.generate(99, (index) {
      return popUpItem('${now.year - index}', now.year - index);
    }),
    0,
    (value) {
      birth = DateTime(value, birth.month, birth.day, birth.hour);
      print(birth);
      setState(() {});
    },
  );

  Widget popUp(text, list, double x, select) {
    return PopupMenuButton(
      clipBehavior: .hardEdge,
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 70),
      color: background.first,
      offset: Offset(x, 35),
      itemBuilder: (context) => list,
      onSelected: select,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: .w700, fontSize: 26),
      ),
    );
  }

  PopupMenuItem<int> popUpItem(text, int value) {
    return PopupMenuItem(
      value: value,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: noto,
            fontWeight: .w700,
          ),
        ),
      ),
    );
    ;
  }
}
