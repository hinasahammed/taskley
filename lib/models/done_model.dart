import 'package:hive/hive.dart';
part 'done_model.g.dart';

@HiveType(typeId: 2)
class Donemodel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String desc;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final String type;
  @HiveField(4)
  bool isChecked;

  Donemodel({
    this.isChecked = false,
    required this.title,
    required this.desc,
    required this.dateTime,
    required this.type,
  });
}
