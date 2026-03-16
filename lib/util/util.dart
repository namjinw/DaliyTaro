import 'package:flutter/material.dart';

const fonts = 'NotoSansKR';
const nanun = 'Nanum';
const background = [Color(0xff3B1361), Color(0xff290D45)];
const moonColor = Color(0xfffdf4ce);
final buttonColor = [
  const Color(0xfffdf4ce).withAlpha(80),
  const Color(0xff310073).withAlpha(200),
  const Color(0xff300661),
];
const labelColor = Color(0xffa6a6a6);

double sizew(context) => MediaQuery.sizeOf(context).width;

ShowSnacker(context, icon, text) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    duration: Duration(seconds: 1),
    content: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 10),
        Text(text),
      ],
    ),
  ),
);

void myDialog(context, text) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: background.first,
          borderRadius: .circular(10),
        ),
        padding: .all(16),
        height: 200,
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Image.asset('assets/images/Daily Tarot.png', width: 140,),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: .w600),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: .circular(30),
                child: Container(
                  width: 60,
                  height: 30,
                  child: Center(
                    child: Text('확인', style: TextStyle(color: Colors.white, fontWeight: .w600)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
    );
  }
}
