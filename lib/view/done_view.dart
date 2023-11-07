import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/done_model.dart';
import 'package:taskley/utils/utils.dart';

class Doneview extends StatefulWidget {
  const Doneview({super.key});

  @override
  State<Doneview> createState() => _DoneviewState();
}

class _DoneviewState extends State<Doneview> {
  final colorList = Utils.colorList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done Task'),
      ),
      body: ValueListenableBuilder<Box<Donemodel>>(
        valueListenable: Utils.doneTask().listenable(),
        builder: (context, box, child) {
          final data = box.values.toList().cast<Donemodel>();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final colorIndex = index % colorList.length;
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  tileColor: Colors.greenAccent.withOpacity(.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  leading: Container(
                    height: double.infinity,
                    width: 10,
                    decoration: BoxDecoration(
                      color: colorList[colorIndex],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].title[0].toUpperCase() +
                            data[index].title.substring(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        data[index].type[0].toUpperCase() +
                            data[index].type.substring(1).toLowerCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
