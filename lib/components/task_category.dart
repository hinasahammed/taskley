import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';
import 'package:taskley/view/alert_view.dart';
import 'package:taskley/view/done_view.dart';
import 'package:taskley/view/todo_view.dart';
import 'package:badges/badges.dart' as badges;

class TaskCategory extends StatelessWidget {
  const TaskCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Utils.database().listenable(),
      builder: (context, box, child) {
        final items = box.values
            .toList()
            .cast<TaskModel>()
            .where((task) => task.dateTime.isBefore(
                DateTime.now().toLocal().subtract(const Duration(days: 1))))
            .toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const TodoView());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 57, 111)
                            .withOpacity(.3),
                        border: Border.all(
                            color: const Color.fromARGB(255, 27, 57, 111)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Lottie.asset(
                        'assets/todo.json',
                        width: 60,
                        repeat: false,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'To-Do',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(() => const AlertView());
                      },
                      child: badges.Badge(
                        badgeContent: Text(
                          items.isEmpty ? '0' : items.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(.3),
                            border: Border.all(
                              color: Colors.redAccent,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Lottie.asset(
                            'assets/alert.json',
                            width: 70,
                            repeat: false,
                            height: 70,
                          ),
                        ),
                      )),
                  const Gap(10),
                  const Text(
                    'Alert',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const Doneview());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.3),
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Lottie.asset(
                        'assets/done.json',
                        width: 60,
                        repeat: false,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
