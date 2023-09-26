import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'package:quick_pall_local_repo/pages/LetsGetStartedScreen.dart';
import 'package:quick_pall_local_repo/widgets/WalkThroughWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '/widgets/Buttons.dart';

class WalkThroughScreen extends StatelessWidget {
  const WalkThroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: IntroductionScreen(
      rawPages: [
        WalkThroughWidget(
            imagePath: "assets/images/WalkThrough1.png",
            mainText: "Send Money Across Borders with Ease",
            subText:
                "Say goodbye to costly fees and complicated processes. Let's get started on simplifying your international transactions!"),
        WalkThroughWidget(
            imagePath: "assets/images/WalkThrough2.png",
            mainText: "Safe and Secure Transactions",
            subText:
                "Your financial data is encrypted and stored securely, ensuring that your money is in safe hands."),
        WalkThroughWidget(
            imagePath: "assets/images/WalkThrough3.png",
            mainText: "Manage and Track Your Money in One Place",
            subText:
                "Need to send money urgently? No problem! With QuickPal, you can transfer funds quickly and conveniently, even on the go.")
      ],
      overrideDone: Widget_ElevatedButton(
          text: "Continue",
          backGroundColor: Colors.green,
          borderColor: Colors.green.shade50,
          textColor: Colors.white,
          callBack: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('hasSeenOnboarding', true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LetsGetStartedScreen()));
          }),
      // overrideDone: ElevatedButton(
      //   child: Text("Continue",
      //       style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
      //   onPressed: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     prefs.setBool('hasSeenOnboarding', true);
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => a()));
      //   },
      //   style: ElevatedButton.styleFrom(
      //       side: BorderSide(color: Colors.green.shade50, width: 1),
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(20))),
      //       backgroundColor: Colors.green),
      // ),
      showSkipButton: true,
      skip: Widget_OutlinedButton(
          text: "Skip", textColor: Colors.green, callback: null),
      doneStyle: TextButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      skipStyle: TextButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 55),
            borderRadius: BorderRadius.circular(8.0)),
      ),
      showNextButton: false,
      globalBackgroundColor: Colors.white,
      safeAreaList: [true, true, true, true],
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.green,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
      ),
    )));
  }
}
