import 'package:flutter/material.dart';

import '../../util/util.dart';

class BaseTextFiled extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback validate;

  const BaseTextFiled({super.key, required this.controller, required this.label, required this.validate});

  @override
  State<BaseTextFiled> createState() => _BaseTextFiledState();
}

class _BaseTextFiledState extends State<BaseTextFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextFormField(
        controller: widget.controller,
        onEditingComplete: () {
          widget.validate();
          FocusScope.of(context).unfocus();
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontWeight: .w600
        ),
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: .symmetric(horizontal: 20, vertical: 13),
            hintText: widget.label,
            hintStyle: TextStyle(
              fontWeight: .w600,
              color: labelColor
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 1, color: Colors.white.withAlpha(150))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 1, color: Colors.white)
            )
        ),
      ),
    );
  }
}
