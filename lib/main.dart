import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/pages/SplashScreen.dart';
import 'package:quick_pall_local_repo/pages/WalkThroughScreen.dart';
import 'package:quick_pall_local_repo/pages/LetsGetStartedScreen.dart';

void main() {
  runApp(MaterialApp(
    title: "Quick Pall",
    home: SplashScreen(),
    // home: LetsGetStartedScreen(),
  ));
}

class a extends StatelessWidget {
  const a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("azan"),
    );
  }
}
