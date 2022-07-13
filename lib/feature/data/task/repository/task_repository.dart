// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_core/core/utils/http_call_utils.dart';
import 'package:test_task/config/network/exception/global_app_exception.dart';
import 'package:test_task/config/network/repository/network_service_repository.dart';
import 'package:test_task/di/di_locator.dart';
import 'package:test_task/feature/data/task/data/task_data_model.dart';

/// репозиторий для онлайн шпор
class TaskRepository {
  final TaskApiService _apiService;
  TaskRepository() : _apiService = locator();

  ///получаем список вопросов для онлайн шпор с бэка
  Future<TaskListModel> getTaskList() async => safeApiCallWithError(
        _apiService.getTaskListRequest(),
        (response) => TaskListModel.fromJson(response),
        (error, defaultError, code) {
          return AuthException(status: code, detail: error);
        },
      );
}
