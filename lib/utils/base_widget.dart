import 'package:dailytaro/utils/utils.dart';
import 'package:flutter/material.dart';

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
        borderSide: BorderSide(color: Colors.white.withAlpha(220), width: 1.2),
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
        borderSide: BorderSide(color: Colors.white.withAlpha(150), width: 1.5),
      ),
    ),
  );
}
