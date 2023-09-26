import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'package:quick_pall_local_repo/pages/WalkThroughScreen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quick_pall_local_repo/widgets/Buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LetsGetStartedScreen extends StatelessWidget {
  const LetsGetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: Widget_OutlinedButton(
                  text: "Sign Up", callback: () {}, textColor: Colors.black),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              child: Widget_ElevatedButton(
                  text: "Sign In",
                  callBack: () {},
                  textColor: Colors.black,
                  backGroundColor: Colors.green,
                  borderColor: Colors.green.shade100),
            )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png"),
              SizedBox(
                height: 70,
              ),
              Text("Let's Get Started!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "With QuickPal, sending and receiving money is easier than ever before.",
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
      ),
    );
  }
}
