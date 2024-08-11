import 'package:get/get.dart';
import 'package:flutter/material.dart';


class GetXHome extends GetXState
{
  // RxInt count=0.obs;


}
class HomeProvider extends ChangeNotifier
{
  DateTime dateTime = DateTime.now();
  void dateDay()
  {
    dateTime;
    notifyListeners();
  }
}