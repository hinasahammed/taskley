import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';
import 'package:taskley/view/task_details_view.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final colorList = Utils.colorList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Utils.database().listenable(),
        builder: (context, box, child) {
          final data = box.values.toList().cast<TaskModel>();

          return data.isEmpty
              ? const Center(
                  child: Text('No Task Found!'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final colorIndex = index % colorList.length;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            () => TaskDetailsView(
                              taskmodel: data[index],
                            ),
                          );
                        },
                        leading: Container(
                          height: double.infinity,
                          width: 10,
                          decoration: BoxDecoration(
                            color: colorList[colorIndex],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        title: Text(
                          data[index].title[0].toUpperCase() +
                              data[index].title.substring(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          data[index].desc[0].toUpperCase() +
                              data[index].desc.substring(1),
                          style: const TextStyle(),
                        ),
                        trailing: Text(
                          DateFormat.yMMMd().format(data[index].dateTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
