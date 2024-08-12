import 'package:isar/isar.dart';
part 'isar_habit.g.dart';

@Collection()
class HomeHabit
{
  Id id= Isar.autoIncrement;
  late String name;
  int? number;
  List<int> dateTimeOk=[
  ];
}