import 'dart:math' as math;

import 'package:dailytaro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/userController.dart';

class BaseWidget {
  static Widget baseFiled(controller, label, context, VoidCallback valid, {length = 30}) => TextFormField(
    controller: controller,
    maxLines: 1,
    onTapOutside: (event) {
      FocusScope.of(context).unfocus();
    },
    onEditingComplete: () {
      valid();
      FocusScope.of(context).unfocus();
    },
    cursorColor: Colors.white,
    maxLength: length,
    style: TextStyle(
      color: Colors.white,
      fontFamily: noto,
      fontWeight: .w400,
      fontSize: 15,
    ),
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      counterText: '',
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white.withAlpha(200), width: 1.2),
      ),
      hintText: label,
      hintStyle: TextStyle(
        color: Colors.white.withAlpha(140),
        fontFamily: noto,
        fontWeight: .w500,
        fontSize: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white.withAlpha(200), width: 1.5),
      ),
    ),
  );

  static Widget button(ontap, double padding) => Padding(
    padding: EdgeInsets.only(top: padding),
    child: Container(
      width: 190,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: .circular(60),
        boxShadow: [
          BoxShadow(
            color: buttonColor.first.withAlpha(80),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: .topLeft,
          end: .bottomCenter,
          stops: [0.1, 0.9],
          colors: buttonColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          borderRadius: .circular(60),
          child: Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(
                '시작하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: .w800,
                ),
              ),

              SizedBox(
                width: 25,
                child: Transform(
                  transform: Matrix4.translationValues(30, 0, 0)
                    ..rotateY(math.pi),
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  
  static Widget dialogButton(text, ontap) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: ontap,
      borderRadius: .circular(30),
      child: Container(
        padding: .symmetric(horizontal: 10, vertical: 4),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .w800,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
