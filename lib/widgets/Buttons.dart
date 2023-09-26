import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'dart:io';

class Widget_ElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backGroundColor;
  final Color borderColor;
  final VoidCallback callBack;
  const Widget_ElevatedButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backGroundColor,
      required this.borderColor,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.text,
          style: TextStyle(fontWeight: FontWeight.w700, color: this.textColor)),
      onPressed: this.callBack,
      style: ElevatedButton.styleFrom(
          side: BorderSide(color: this.borderColor, width: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: this.backGroundColor),
    );
  }
}

class Widget_OutlinedButton extends StatelessWidget {
  final Color textColor;
  final String text;
  final VoidCallback? callback;
  const Widget_OutlinedButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: this.callback,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      child: Text(
        this.text,
        style: TextStyle(color: this.textColor),
      ),
    );
  }
}
