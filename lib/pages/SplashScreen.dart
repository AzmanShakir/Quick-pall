import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'package:quick_pall_local_repo/pages/WalkThroughScreen.dart';
import 'dart:io';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key}) 

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      File file = File('test.txt');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WalkThroughScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                ),
                LoadingAnimationWidget.staggeredDotsWave(
                  // LoadingAnimationwidget that call the
                  color: Colors.green, // staggereddotwave animation
                  size: 50,
                ),
              ],
            ),
          )),
    );
  }
}
