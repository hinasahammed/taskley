import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
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

  TaskModel({
    this.isChecked = false,
    required this.title,
    required this.desc,
    required this.dateTime,
    required this.type,
  });
}
