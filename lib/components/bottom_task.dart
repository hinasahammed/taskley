import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';

class BottomTask extends StatefulWidget {
  const BottomTask({super.key});

  @override
  State<BottomTask> createState() => _BottomTaskState();
}

class _BottomTaskState extends State<BottomTask> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: Utils.database().listenable(),
      builder: (context, box, child) {
        final data = box.values.toList().cast<TaskModel>();
        return ListView.separated(
          separatorBuilder: (context, index) => const Gap(10),
          reverse: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 0,
            top: 10,
          ),
          itemCount: data.isNotEmpty && data.length <= 3 ? data.length : 3,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                top: 7,
                bottom: 7,
                right: 12,
                left: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 205, 203, 203), // Shadow color
                    offset: Offset(0, 4), // Offset from the container
                    blurRadius: 6, // Spread of the shadow
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title[0].toUpperCase() +
                              data[index].title.substring(1),
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data[index].desc[0].toUpperCase() +
                              data[index].desc.substring(1),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.circle,
                    size: 10,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
