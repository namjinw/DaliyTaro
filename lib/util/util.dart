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
