import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_habit_tracker/modal/app_settings.dart';
import 'package:minimal_habit_tracker/modal/isar_habit.dart';
import 'package:path_provider/path_provider.dart';

class GetXHome extends GetxController {
  // RxInt count=0.obs;
  RxBool isDark=true.obs;
  RxBool isHeatMap=true.obs;
  void darkThemeMethod()
  {
    isDark.value=!isDark.value;
  }
  void heatMapChange()
  {
    isHeatMap.value=!isHeatMap.value;
  }
}

class HomeProvider extends ChangeNotifier {
  DateTime dateTime = DateTime.now();
  int numberColor = 0;
  void dateDay() {
    dateTime = DateTime.now();
    notifyListeners();
  }

  List<int> checkList = [];

  void colorListMethodCheckBox(int index) {
    if (checkList.contains(index)) {
      checkList.remove(index);
    } else {
      checkList.add(index);
    }
    // if(checkList.isEmpty)
    //   {
    //     checkList.add(index);
    //   }
    print('Update me -> $checkList');
    notifyListeners();
  }

  // Todo Isar create line code ---------------->Praful<--------------------
  static late Isar isar;

  static Future<void> isarInstance() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([HomeHabitSchema, AppSettingsSchema],
        directory: dir.path);
    // final isar= await Isar.open([HomeHabitSchema,AppSettingsSchema], directory: dir.path);
  }

  Future<void> setData() async {
    final dataSetting = await isar.appSettings.where().findFirst();
    if (dataSetting == null) {
      final setting = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(setting));
    }
  }

  Map<DateTime, int> dateSetAll = {};

  Future<void> readData() async {
    final readDataSave = await isar.appSettings.where().findAll();
    // print(readData.);
    dateSetAll.clear();
    for (int i = 0; i < readDataSave.length; i++) {
      dateSetAll.addAll({
        DateTime(
                readDataSave[i].firstLaunchDate!.year,
                readDataSave[i].firstLaunchDate!.month,
                readDataSave[i].firstLaunchDate!.day):
            readDataSave[i].checkListSetting.length,
      });
    }
    checkList.clear();
    for (int i = 0; i < readDataSave.length; i++) {
      checkList.addAll(readDataSave[i].checkListSetting);
    }
    // print("${readDataSave[0].firstLaunchDate} ${DateTime.now()}");
    notifyListeners();
  }

  Future<void> updateData(int index) async {
    final readDataSave = await isar.appSettings.where().findAll();
    int id = 0;
    for (int i = 0; i < dateSetAll.length; i++) {
      if (DateTime(dateTime.year, dateTime.month, dateTime.day) ==
          DateTime(
              readDataSave[i].firstLaunchDate!.year,
              readDataSave[i].firstLaunchDate!.month,
              readDataSave[i].firstLaunchDate!.day)) {
        id = thisTimeHabitList[i].id;
      }
    }
    final habit = await isar.appSettings.get(id);

    int valueInt = 0;
    numberColor = valueInt;
    if (habit != null) {
      await isar.writeTxn(
        () async {
          habit.number = checkList.length;
          habit.checkListSetting = checkList;
          print(habit.checkListSetting);
          await isar.appSettings.put(habit);
        },
      );
    }
    readData();
  }

  Future<DateTime?> getData() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  final List<HomeHabit> thisTimeHabitList = []; // todo this list using

  Future<void> addHabit(String habitName) async {
    // numberColor++;
    bool id = true;
    for (int i = 0; i < thisTimeHabitList.length; i++) {
      if (habitName == thisTimeHabitList[i].name) {
        id = false;
      }
    }
    if (id == true) {
      final newHabit = HomeHabit()..name = habitName;
      await isar.writeTxn(
        () async {
          await isar.homeHabits.put(newHabit);
        },
      );
    }
    readHabit();
  }

  HomeProvider() {
    readHabit();
    readData();
  }

  Future<void> readHabit() async {
    final readData = await isar.homeHabits.where().findAll();
    // final readDataSave = await isar.appSettings.where().findAll();
    // print(readData.);
    thisTimeHabitList.clear();
    thisTimeHabitList.addAll(readData);
    // print(thisTimeHabitList[0]);
    notifyListeners();
  }

  Future<void> updateHabitName(
      {required String value, required String newName}) async {
    int id = 0;
    bool same = true;
    for (int i = 0; i < thisTimeHabitList.length; i++) {
      if (value == thisTimeHabitList[i].name) {
        id = thisTimeHabitList[i].id;
      }
      if (value == newName) {
        same = false;
      }
    }
    if (same == true) {
      final habit = await isar.homeHabits.get(id);
      if (habit != null) {
        await isar.writeTxn(
          () async {
            habit.name = newName;
            await isar.homeHabits.put(habit);
          },
        );
      }
    }
    readHabit();
  }

  // bool valueBool=true;

  Future<void> updateIndex(String value, int index) async {
    int id = 0;
    for (int i = 0; i < thisTimeHabitList.length; i++) {
      if (value == thisTimeHabitList[i].name) {
        id = thisTimeHabitList[i].id;
      }
    }
    final habit = await isar.homeHabits.get(id);
    if (habit != null) {
      await isar.writeTxn(
        () async {
          if (index != habit.number) {
            habit.number = index;
          } else {
            habit.number = null;
          }
          await isar.homeHabits.put(habit);
        },
      );
    }
    readHabit();
  }

  Future<void> deleteHabit(String value, int index) async {
    checkList.remove(index);
    int id = 0;
    for (int i = 0; i < thisTimeHabitList.length; i++) {
      if (value == thisTimeHabitList[i].name) {
        id = thisTimeHabitList[i].id;
      }
    }
    await isar.writeTxn(
      () async {
        await isar.homeHabits.delete(id);
      },
    );
    readHabit();
  }
}
