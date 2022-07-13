import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_state.dart';
import 'package:provider/provider.dart';
import 'package:test_task/feature/presentation/cubit/task_cubit.dart';
import 'package:test_task/feature/presentation/cubit/task_state.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TaskCubit _taskCubit;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _taskCubit = context.read<TaskCubit>();
    _taskCubit.setCreatState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text('Add Task', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.black)),
        ),
        body: CoreUpgradeBlocBuilder<TaskCubit, CoreState>(
            cubit: _taskCubit,
            listener: (context, state) {
              if (state is CreateTaskState) {
                if (state.isSaved) {
                  _taskCubit.getTaskList();
                  Navigator.of(context).pop();
                }
              }
            },
            buildWhen: (previous, current) => current is CreateTaskState,
            builder: (_, state) {
              if (state is CreateTaskState) {
                return Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Title',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  controller:
                                      _taskCubit.getEditingTitleController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                    hintText: 'Design team meeting',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12, top: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your user name.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Deadline',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  controller:
                                      _taskCubit.getEditingDeadlineController,
                                  autofocus: false,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                    hintText: '2021-02-08',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12, top: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your user name.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Start Time',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      TextFormField(
                                        cursorColor: Colors.black,
                                        autofocus: false,
                                        controller: _taskCubit
                                            .getEditingStartTimeController,
                                        style: const TextStyle(fontSize: 16),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              Colors.grey.withOpacity(0.15),
                                          suffixIcon:
                                              const Icon(Icons.timer_rounded),
                                          hintText: '11:00am',
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 12, top: 12),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your user name.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'End Time',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      TextFormField(
                                        cursorColor: Colors.black,
                                        autofocus: false,
                                        controller: _taskCubit
                                            .getEditingEndTimeController,
                                        style: const TextStyle(fontSize: 16),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          suffixIcon:
                                              const Icon(Icons.timer_rounded),
                                          fillColor:
                                              Colors.grey.withOpacity(0.15),
                                          hintText: '14:00',
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 12, top: 12),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your user name.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Remind',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  controller:
                                      _taskCubit.getEditingReminderController,
                                  autofocus: false,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                    hintText: '10 minutes early',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12, top: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your user name.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Repeat',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  controller:
                                      _taskCubit.getEditingRepeatController,
                                  autofocus: false,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                    hintText: 'Weakly',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 12, top: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your user name.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(25),
          child: TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (formKey.currentState.validate()) {
                inspect(formKey.currentState.validate());
                formKey.currentState.save();
                _taskCubit.createTask();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Task", style: TextStyle(fontSize: 17)),
            ),
          ),
        ),
      ),
    );
  }
}
