import 'package:flutter/material.dart';

const noto = 'NotoSansKR';
const nanum = 'NaNum';
const background = [Color(0xff3c1361), Color(0xff260c3f)];
const buttonColor = [Color(0xff846679), Color(0xff3c1462)];
const stateButtonColor = Color(0xd3432066);

double sizew(context) => MediaQuery.sizeOf(context).width;
double sizeh(context) => MediaQuery.sizeOf(context).height;

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