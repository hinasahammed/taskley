import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  List<String> types = ['Daily', 'Fun', 'Development', 'Decision', 'Search'];
  String _dropValue = 'Daily';
  DateTime? selectedDate;
  var formattedDate = '';

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  void pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    final formatted = DateFormat.yMMMd().format(pickedDate!);
    setState(() {
      selectedDate = pickedDate;
      formattedDate = formatted;
    });
  }

  void saveData() {
    final data = TaskModel(
      title: _titleController.text,
      desc: _descController.text,
      dateTime: selectedDate!,
      type: _dropValue,
    );
    final box = Utils.database();
    box.add(data);
    data.save();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                maxLength: 60,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: pickDate,
                      icon: const Icon(Icons.arrow_drop_down),
                      label: formattedDate.isEmpty
                          ? const Text(
                              'Select Date',
                            )
                          : Text(
                              formattedDate,
                            ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _dropValue,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 0,
                      isExpanded: true,
                      items: types
                          .map(
                            (String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          selectedDate != null) {
                        saveData();
                      }
                      return;
                    },
                    child: Text(
                      'Add task',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
