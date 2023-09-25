import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_pall_local_repo/main.dart';
import 'package:quick_pall_local_repo/widgets/WalkThroughWidget.dart';
import 'dart:io';

class WalkThroughScreen extends StatelessWidget {
  const WalkThroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WalkThroughWidget(
            imagePath: "assets/images/WalkThrough1.png",
            mainText: "Send Money Across Borders with Ease",
            subText:
                "Say goodbye to costly fees and complicated processes. Let's get started on simplifying your international transactions!"));
  }
}
