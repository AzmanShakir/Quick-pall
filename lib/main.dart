import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/pages/HomeScreen.dart';
import 'package:quick_pall_local_repo/pages/SplashScreen.dart';
import 'package:quick_pall_local_repo/pages/WalkThroughScreen.dart';
import 'package:quick_pall_local_repo/pages/LetsGetStartedScreen.dart';
import 'package:quick_pall_local_repo/Models/AccountHolder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: "Quick Pall",
    home: SplashScreen(),
    // home: SplashScreen(),
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
