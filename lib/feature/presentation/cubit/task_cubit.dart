// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:test_task/config/network/exception/global_app_exception.dart';
import 'package:test_task/di/di_locator.dart';
import 'package:test_task/feature/data/task/data/task_data_model.dart';
import 'package:test_task/feature/domain/task/usecase/task_usecase.dart';
import 'task_state.dart';

///наш кубит для онлайн шпор
class TaskCubit extends CoreCubit {
  TaskCubit()
      : _getTaskListUseCase = locator(),
        _setTaskListSourceUseCase = locator(),
        _getTaskListSourceUseCase = locator(),
        super(TaskState());

  ///наш useCase
  final GetTaskListUseCase _getTaskListUseCase;
  final SetTaskListSourceUseCase _setTaskListSourceUseCase;
  final GetTaskListSourceUseCase _getTaskListSourceUseCase;
  TaskListModel _taskData;
  List<Status> status = [Status.ALL];
  Timer _filterTimer;

  final _editingTitleController = TextEditingController();
  TextEditingController get getEditingTitleController =>
      _editingTitleController;

  final _editingDeadlineController = TextEditingController();
  TextEditingController get getEditingDeadlineController =>
      _editingDeadlineController;

  final _editingStartTimeController = TextEditingController();
  TextEditingController get getEditingStartTimeController =>
      _editingStartTimeController;

  final _editingEndTimeController = TextEditingController();
  TextEditingController get getEditingEndTimeController =>
      _editingEndTimeController;

  final _editingReminderController = TextEditingController();
  TextEditingController get getEditingReminderController =>
      _editingReminderController;

  final _editingRepeatController = TextEditingController();
  TextEditingController get getEditingRepeatController =>
      _editingRepeatController;

  /// getting all list of tasks from server
  Future<void> getTaskList() async {
    final state = _getTaskState();
    final request = _getTaskListUseCase.execute();

    launchWithError<GetTaskListResult, AuthException>(
      request: request,
      loading: (isLoading) {
        emit(state.copyWith(isLoading: true));
      },
      resultData: (result) async {
        TaskListModel _local = TaskListModel(tasks: []);

        _taskData = result.taskModel;
        for (var i = 0; i < result.taskModel.tasks.length; i++) {
          if (result.taskModel.tasks[i].status is Status) {
            if (!status.contains(result.taskModel.tasks[i].status)) {
              status.add(result.taskModel.tasks[i].status);
            }
          }
        }

        for (var i = 0; i < _taskData.tasks.length; i++) {
          _local.tasks.add(_taskData.tasks[i]);
        }
        final localSavedTasks = await _getTaskListSourceUseCase.execute();
        if (localSavedTasks?.taskModel?.tasks?.isNotEmpty ?? false) {
          _local.tasks.addAll(localSavedTasks.taskModel.tasks);
          _taskData.tasks.addAll(localSavedTasks.taskModel.tasks);
        }

        emit(state.copyWith(taskModel: _local, status: status));
      },
      errorData: (error) {
        emit(state);
        emit(UstudyGiveawayErrorState(errorTxt: error.detail.toString()));
        showErrorCallback.call(error.detail);
      },
    );
  }

  /// call when we scroll or tap tabbar
  void tabChanged(int index) {
    final state = _getTaskState();
    TaskListModel local = TaskListModel(tasks: []);

    for (var i = 0; i < _taskData.tasks.length; i++) {
      if (index != 0) {
        if (_taskData.tasks[i].status == status[index]) {
          local.tasks.add(_taskData.tasks[i]);
        }
      } else {
        local.tasks.add(_taskData.tasks[i]);
      }
    }
    emit(state.copyWith(taskModel: local, status: status));
  }

  /// when we create new task locally
  Future<void> createTask() async {
    TaskModel taskModel = TaskModel();
    taskModel.status = Status.PENDING;
    taskModel.title = getEditingTitleController.text;
    taskModel.reminder = getEditingReminderController.text;
    taskModel.repeat = getEditingReminderController.text;
    taskModel.startTime = getEditingStartTimeController.text;
    taskModel.deadline = getEditingDeadlineController.text;
    taskModel.toJson();
    TaskListModel temp = TaskListModel(tasks: []);
    final localNotes = await _getTaskListSourceUseCase.execute();
    if (localNotes.taskModel.tasks != null) {
      temp.tasks.addAll(localNotes.taskModel.tasks);
    }
    temp.tasks.add(taskModel);
    await _setTaskListSourceUseCase.execute(temp.toJson());
    _editingTitleController.clear();
    _editingDeadlineController.clear();
    _editingReminderController.clear();
    _editingRepeatController.clear();
    _editingStartTimeController.clear();
    _editingEndTimeController.clear();
    emit(CreateTaskState(isSaved: true));
  }

  ///init state for create screen
  void setCreatState() {
    emit(CreateTaskState());
  }

  /// to search needed word in list of string
  void filterTutorials(String query) {
    TaskListModel _founded = TaskListModel(tasks: []);

    if (_filterTimer != null) {
      _filterTimer.cancel();
    }
    _filterTimer = Timer(const Duration(milliseconds: 500), () {
      if (query == null || query.isEmpty) {
        _founded = _taskData;
      } else {
        _founded.tasks = _taskData.tasks
                .where((item) => item.title.toLowerCase().contains(query))
                .toList() ??
            [];
      }
      emit(SearchTaskState(taskModel: _founded));
    });
  }

  /// возвращает состояние экрана [TaskState]
  TaskState _getTaskState() {
    if (state is TaskState) {
      return state;
    }
    return TaskState(taskModel: _taskData, isLoading: false);
  }
}
