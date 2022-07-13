// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:flutter_core/core/domain/abstract/use_case/core_use_case.dart';
import 'package:test_task/di/di_locator.dart';
import 'package:test_task/feature/data/task/data/task_data_model.dart';
import 'package:test_task/feature/data/task/prefs/task_local_data_source.dart';
import 'package:test_task/feature/data/task/repository/task_repository.dart';

///наш use case с помощью которого мы получаем список вопросов
class GetTaskListUseCase extends CoreFutureNoneParamUseCase<GetTaskListResult> {
  GetTaskListUseCase() : taskRepository = locator();

  final TaskRepository taskRepository;
  @override
  Future<GetTaskListResult> execute() async {
    final result = await taskRepository.getTaskList();

    return GetTaskListResult(taskModel: result);
  }
}

///результат с [GetUstudyGiveawayUseCase]
class GetTaskListResult {
  final TaskListModel taskModel;
  GetTaskListResult({this.taskModel});
}

///наш use case с помощью которого мы получаем список вопросов
class SetTaskListSourceUseCase extends CoreFutureUseCase<String, void> {
  SetTaskListSourceUseCase() : globalTaskDataSource = locator();

  final GlobalTaskDataSource globalTaskDataSource;
  @override
  Future<void> execute(String param) async {
    log('$param');
    globalTaskDataSource.setTask(param);
  }
}

///наш use case с помощью которого мы получаем список вопросов
class GetTaskListSourceUseCase
    extends CoreFutureNoneParamUseCase<GetTaskListSourceResult> {
  GetTaskListSourceUseCase() : globalTaskDataSource = locator();

  final GlobalTaskDataSource globalTaskDataSource;
  @override
  Future<GetTaskListSourceResult> execute() async {
    final res = await globalTaskDataSource.taskList;
    if (res == null) return GetTaskListSourceResult(taskModel: TaskListModel());
    return GetTaskListSourceResult(taskModel: TaskListModel.fromRawJson(res));
  }
}

class GetTaskListSourceResult {
  final TaskListModel taskModel;
  GetTaskListSourceResult({this.taskModel});
}
