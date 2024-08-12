// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
// import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:minimal_habit_tracker/controller/home_get_controller.dart';
import 'package:provider/provider.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Obx(() => Text("${getXHome.dateTime.value.second}"),),
                // Text(homeProviderTrue.dateTime.toString()),
                HeatMapCalendar(
                  defaultColor: Theme.of(context).colorScheme.onError,
                  flexible: true,
                  showColorTip: false,
                  weekTextColor: Theme.of(context).colorScheme.onSurface,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  colorMode: ColorMode.color,
                  datasets: {

                  },
                  colorsets: {
                    1: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    2: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    3: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    4: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    5: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    6: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                    7: Theme.of(context).colorScheme.secondary.withOpacity(1),
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                            color: (index == homeProviderTrue.thisTimeHabitList[index].number) ?Colors.green:Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  TextEditingController txtController = TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: TextFormField(
                                        controller: txtController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black)),
                                        ),
                                      ),
                                      actions: [
                                        MaterialButton(onPressed: () {
                                          // homeProviderFalse.updateData(1,removeAndAddValue: true);
                                          context.read<HomeProvider>().updateHabitName(value:homeProviderTrue.thisTimeHabitList[index].name,newName: txtController.text.toString());
                                          Navigator.of(context).pop();
                                        },child: const Text("Save"),),
                                        MaterialButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        },child: const Text("Cancel"),),
                                      ],
                                    ),
                                  );
                                },
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                icon: Icons.edit,
                                label: "Edit",
                              ),
                              SlidableAction(
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                onPressed: (context) {
                                  homeProviderFalse.deleteHabit(homeProviderTrue.thisTimeHabitList[index].name, index);
                                },
                                label: "Delete",
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Checkbox.adaptive(
                              value: (index == homeProviderTrue.thisTimeHabitList[index].number) ? true : false,
                              onChanged: (value) {
                                homeProviderFalse.updateIndex(homeProviderTrue.thisTimeHabitList[index].name,index);
                                homeProviderFalse.updateData(index);
                                },
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(homeProviderTrue.thisTimeHabitList[index].name),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController txtController = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: TextFormField(
                  controller: txtController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                actions: [
                  MaterialButton(onPressed: () {
                    // homeProviderFalse.updateData(1,removeAndAddValue: true);
                    context.read<HomeProvider>().addHabit(txtController.text.toString());
                    Navigator.of(context).pop();
                  },child: const Text("Save"),),
                  MaterialButton(onPressed: () {
                    Navigator.of(context).pop();
                  },child: const Text("Cancel"),),
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

//TODO this logic have create and last one implement.
//TODO--------------------------------->PRAFUL<-----------------------------------------
// HeatMap(
// defaultColor: Colors.white,
// colorMode: ColorMode.color,
// showText: true,
// textColor: Colors.black,
// showColorTip: true,
// datasets: {
// DateTime(dateTime.year,dateTime.month,dateTime.day):0,
// },
// colorsets: {
// 1: Colors.green.withOpacity(0.1),
// 2: Colors.green.withOpacity(0.2),
// 3: Colors.green.withOpacity(0.3),
// 4: Colors.green.withOpacity(0.4),
// 5: Colors.green.withOpacity(0.5),
// 6: Colors.green.withOpacity(0.6),
// 7: Colors.green.withOpacity(0.9),
// },
// startDate: DateTime(dateTime.year,dateTime.month,dateTime.day),
// endDate: DateTime(dateTime.year,dateTime.month,dateTime.day),
// onClick: (value) {
// ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
// },
// )
