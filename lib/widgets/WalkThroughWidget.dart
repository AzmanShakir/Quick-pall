import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'dart:io';

class WalkThroughWidget extends StatelessWidget {
  final imagePath;
  final mainText;
  final subText;

  WalkThroughWidget(
      {required this.imagePath, required this.mainText, required this.subText});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(children: [
      Container(
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 40),
          child: Image.asset(
            imagePath,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                mainText,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                subText,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Color.fromARGB(200, 51, 65, 85)),
                textAlign: TextAlign.center,
              ),
            ]),
        margin: const EdgeInsets.only(top: 440.0, bottom: 40),
        height: 500,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(150, 40),
                topRight: Radius.elliptical(150, 40))),
      )
    ])));
  }
}
