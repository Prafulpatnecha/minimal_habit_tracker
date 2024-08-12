import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Get.toNamed("/");
    },);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [],),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://habityou.com/wp-content/uploads/elementor/thumbs/habityou-habit-tracker-journal-day-planner-p7zjzyjkb21epz4mtv72bvhosykozvcg058x82n13w.png"),
                    fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
