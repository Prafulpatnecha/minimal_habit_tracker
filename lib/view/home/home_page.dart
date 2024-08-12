// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

// import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:minimal_habit_tracker/controller/home_get_controller.dart';
import 'package:provider/provider.dart';

import '../components/heat_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GetXHome getXHome = Get.put(GetXHome());
    HomeProvider homeProviderTrue = Provider.of(context, listen: true);
    HomeProvider homeProviderFalse = Provider.of(context, listen: false);
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   getXHome.dateDay();
    // },);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              getXHome.heatMapChange();
            }, icon: Icon(Icons.change_circle))
          ],
          leading: IconButton(onPressed: () {
            getXHome.darkThemeMethod();
          }, icon: Icon(Icons.color_lens_rounded)),
          title: const Text("Habit Tracker"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Obx(
              () =>  Column(
                children: [
                  // Obx(() => Text("${getXHome.dateTime.value.second}"),),
                  // Text(homeProviderTrue.dateTime.toString()),
                  (getXHome.isHeatMap.value==true)?buildHeatMapCalendar(context, homeProviderTrue):
                  buildHeatMap(context, homeProviderTrue),
                  SizedBox(
                    height: 50,
                  ),
                  ...List.generate(
                    homeProviderTrue.thisTimeHabitList.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: (index ==
                                      homeProviderTrue
                                          .thisTimeHabitList[index].number)
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.onError,
                              borderRadius: BorderRadius.circular(20)),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    TextEditingController txtController =
                                        TextEditingController();
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: TextFormField(
                                          controller: txtController,
                                          decoration: InputDecoration(
                                            label: Text("Edit",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).colorScheme.onPrimary)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).colorScheme.onPrimary)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).colorScheme.onPrimary)),
                                          ),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              // homeProviderFalse.updateData(1,removeAndAddValue: true);
                                              context
                                                  .read<HomeProvider>()
                                                  .updateHabitName(
                                                      value: homeProviderTrue
                                                          .thisTimeHabitList[
                                                              index]
                                                          .name,
                                                      newName: txtController.text
                                                          .toString());
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Save",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  foregroundColor: Theme.of(context).colorScheme.onError,
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  icon: Icons.edit,
                                  label: "Edit",
                                ),
                                SlidableAction(
                                  foregroundColor: Theme.of(context).colorScheme.onError,
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                  onPressed: (context) {
                                    // homeProviderFalse.colorListMethodCheckBox(index);
                                    homeProviderFalse.deleteHabit(
                                        homeProviderTrue
                                            .thisTimeHabitList[index].name,
                                        index);
                                    homeProviderFalse.updateData(index);
                                  },
                                  label: "Delete",
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Checkbox.adaptive(
                                value: (index ==
                                        homeProviderTrue
                                            .thisTimeHabitList[index].number)
                                    ? true
                                    : false,
                                onChanged: (value) async {
                                  homeProviderFalse
                                      .colorListMethodCheckBox(index);
                                  homeProviderFalse.updateIndex(
                                      homeProviderTrue
                                          .thisTimeHabitList[index].name,
                                      index);
                                  homeProviderFalse.updateData(index);
                                },
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(homeProviderTrue
                                    .thisTimeHabitList[index].name,style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController txtController = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: TextFormField(
                  controller: txtController,
                  decoration: InputDecoration(
                    label: Text("Create",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      // homeProviderFalse.updateData(1,removeAndAddValue: true);
                      context
                          .read<HomeProvider>()
                          .addHabit(txtController.text.toString());
                      Navigator.of(context).pop();
                    },
                    child: Text("Save",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// DateTime dateTime = DateTime.now();

