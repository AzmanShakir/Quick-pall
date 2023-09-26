import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'package:quick_pall_local_repo/pages/WalkThroughScreen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasSeenWalkthrough = false;
  // void _checkSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _hasSeenWalkthrough = prefs.getBool('hasSeenOnboarding') ?? false;
  // }

  // Widget _chooseScreen() {
  //   _checkSeen();
  //   if (_hasSeenWalkthrough == true) {
  //     return a();
  //   } else {
  //     return WalkThroughScreen();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _hasSeenWalkthrough = prefs.getBool('hasSeenOnboarding') ?? false;
      if (_hasSeenWalkthrough == true) {
        Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (context) => WalkThroughScreen()));
            MaterialPageRoute(builder: (context) => a()));
      } else {
        Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (context) => WalkThroughScreen()));
            MaterialPageRoute(builder: (context) => WalkThroughScreen()));
      }

      // MaterialPageRoute(builder: _chooseScreen(context)));
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
