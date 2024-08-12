
import 'package:isar/isar.dart';
part 'app_settings.g.dart';

@Collection()
class AppSettings{
  Id id= Isar.autoIncrement;
  DateTime? firstLaunchDate;
  int? number;
  List<int> checkListSetting=[];
}