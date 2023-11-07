import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskley/components/task_details_top_session.dart';
import 'package:taskley/models/done_model.dart';
import 'package:taskley/models/task_model.dart';
import 'package:taskley/utils/utils.dart';

class TaskDetailsView extends StatefulWidget {
  final TaskModel taskmodel;
  const TaskDetailsView({
    super.key,
    required this.taskmodel,
  });

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  var _currentStep = 0;
  var isCompleted = false;

  List<Step> getSteps() => [
        Step(
          isActive: _currentStep >= 0,
          title: Text(
            widget.taskmodel.title[0].toUpperCase() +
                widget.taskmodel.title.substring(1).toLowerCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/black_container.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.taskmodel.title[0].toUpperCase() +
                            widget.taskmodel.title.substring(1).toLowerCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(widget.taskmodel.dateTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.taskmodel.desc[0].toUpperCase() +
                      widget.taskmodel.desc.substring(1).toLowerCase(),
                  style: const TextStyle(
                    color: Color.fromARGB(222, 255, 255, 255),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  void showAlert(TaskModel taskModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text(
              "Are you sure you want to delete this task? This action cannot be undone"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back();

                removeItem(taskModel);
                Get.back();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void removeItem(TaskModel taskModel) async {
    await taskModel.delete();
  }

  void addDoneItem(TaskModel taskModel) async {
    final data = Donemodel(
      title: taskModel.title,
      desc: taskModel.desc,
      dateTime: taskModel.dateTime,
      type: taskModel.type,
    );
    final box = Utils.doneTask();
    await box.add(data);
    await data.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(primary: Colors.black),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TaskDetailsTopsession(
                    taskModel: widget.taskmodel,
                    showAlert: showAlert,
                  )),
              isCompleted
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Lottie.asset('assets/completed.json'),
                    )
                  : Stepper(
                      currentStep: _currentStep,
                      onStepContinue: () async {
                        final isLastStep =
                            _currentStep == getSteps().length - 1;
                        setState(() {
                          if (isLastStep) {
                            isCompleted = true;
                            addDoneItem(widget.taskmodel);
                            removeItem(widget.taskmodel);
                            Timer(
                                const Duration(
                                  seconds: 2,
                                ), () {
                              Get.back();
                            });
                          } else {
                            _currentStep += 1;
                          }
                        });
                      },
                      controlsBuilder: (context, details) {
                        final isLastStep =
                            _currentStep == getSteps().length - 1;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.sizeOf(context).width * .35,
                                  40,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: details.onStepContinue,
                              child: Text(isLastStep ? 'Complete' : 'Next'),
                            ),
                            if (_currentStep != 0)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.sizeOf(context).width * .3,
                                    40,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: details.onStepContinue,
                                child: const Text('Back'),
                              ),
                          ],
                        );
                      },
                      onStepCancel: () {
                        _currentStep == 0
                            ? null
                            : setState(() {
                                _currentStep -= 1;
                              });
                      },
                      onStepTapped: (step) => setState(() {
                        _currentStep = step;
                      }),
                      steps: getSteps(),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
