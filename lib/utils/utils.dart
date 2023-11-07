import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/done_model.dart';
import 'package:taskley/models/task_model.dart';

class Utils {
  static Box<TaskModel> database() => Hive.box<TaskModel>('TaskleyDB');
  static Box<Donemodel> doneTask() => Hive.box<Donemodel>('DoneTask');

  static List colorList = [
    const Color(0xfffb8500),
    const Color(0xff023047),
    const Color(0xffd62828),
    const Color(0xff0d1b2a),
    const Color(0xffff595e),
    const Color(0xfff15bb5),
    const Color(0xff007200),
    const Color(0xff3c6e71),
  ];
  static final ValueNotifier<List<TaskModel>> notifier =
      ValueNotifier(database()
          .values
          .toList()
          .cast<TaskModel>()
          .where(
            (task) => DateFormat.yMMMd().format(task.dateTime).contains(
                  DateFormat.yMMMd().format(
                    DateTime.now(),
                  ),
                ),
          )
          .toList());
}
