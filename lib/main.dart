import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/controller/home_get_controller.dart';
import 'package:minimal_habit_tracker/view/control/ui_control.dart';
import 'package:provider/provider.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeProvider.isarInstance();
  await HomeProvider().setData();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create:(context) => HomeProvider())],
      builder:(context, child) => const MyApp()));
}
