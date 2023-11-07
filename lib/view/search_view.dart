import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';
import 'package:taskley/view/task_details_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  final colorList = Utils.colorList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 55,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _searchController.text = value;
                    },
                  );
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: ValueListenableBuilder<Box<TaskModel>>(
                valueListenable: Utils.database().listenable(),
                builder: (context, box, child) {
                  final data = box.values
                      .toList()
                      .cast<TaskModel>()
                      .where(
                        (task) => task.title.toLowerCase().contains(
                              _searchController.text.toLowerCase(),
                            ),
                      )
                      .toList();

                  return data.isEmpty
                      ? Center(
                          child: _searchController.text.isEmpty
                              ? const Text('not data found!')
                              : Text("'${_searchController.text}' not found!"),
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
                                  ()=>
                                    TaskDetailsView(
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
                                  DateFormat.yMMMd()
                                      .format(data[index].dateTime),
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
            ),
          ],
        ),
      ),
    );
  }
}
