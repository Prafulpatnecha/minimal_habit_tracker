import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_habit_tracker/controller/home_get_controller.dart';
import 'package:minimal_habit_tracker/utils/theme_file.dart';
import 'package:minimal_habit_tracker/view/home/home_page.dart';
import 'package:provider/provider.dart';

import '../splash_screen/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetXHome getXHome = Get.put(GetXHome());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Minimal Habit",
        theme: ThemeEdit.lightTheme,
        darkTheme: ThemeEdit.darkTheme,
        initialRoute: "/splash",
        themeMode:
            (getXHome.isDark.value == true) ? ThemeMode.light : ThemeMode.dark,
        getPages: [
          GetPage(
            name: "/",
            page: () => const HomePage(),
          ),
          GetPage(
            name: "/splash",
            page: () => const SplashPage(),transition: Transition.topLevel
          ),
        ],
      ),
    );
  }
}
