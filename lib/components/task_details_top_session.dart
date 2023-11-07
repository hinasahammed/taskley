import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/task_model.dart';

class TaskDetailsTopsession extends StatefulWidget {
  const TaskDetailsTopsession({
    super.key,
    required this.taskModel,
    required this.showAlert,
  });

  final TaskModel taskModel;
  final Function(TaskModel taskModel) showAlert;

  @override
  State<TaskDetailsTopsession> createState() => _TaskDetailsTopsessionState();
}

class _TaskDetailsTopsessionState extends State<TaskDetailsTopsession> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              DateFormat.yMMMMd().format(widget.taskModel.dateTime) ==
                      DateFormat.yMMMMd().format(DateTime.now())
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
          children: [
            if (DateFormat.yMMMMd().format(widget.taskModel.dateTime) ==
                DateFormat.yMMMMd().format(DateTime.now()))
              Text(
                DateFormat.yMMMMd().format(widget.taskModel.dateTime),
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            IconButton(
              onPressed: () {
                widget.showAlert(widget.taskModel);
              },
              icon: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        Text(
          DateFormat.yMMMMd().format(widget.taskModel.dateTime) ==
                  DateFormat.yMMMMd().format(DateTime.now())
              ? 'Today'
              : DateFormat.yMMMMd().format(widget.taskModel.dateTime),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
