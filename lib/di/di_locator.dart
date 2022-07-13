// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_core/core/di/core_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/config/network/network_clients.dart';
import 'package:test_task/config/network/repository/network_service_repository.dart';
import 'package:test_task/constants/global_app_consts.dart';
import 'package:test_task/feature/data/task/prefs/task_local_data_source.dart';
import 'package:test_task/feature/data/task/repository/task_repository.dart';
import 'package:test_task/feature/domain/task/usecase/task_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  coreModule();
  _commonMainModule();
  _apiServiceModule();
  _dataSourceModule();
  _repositoryModule();
  _useCaseModule();
}

void _commonMainModule() {
  /// для авторизованной зоны
  locator.registerSingletonAsync(
    () => createAuthorizedHttpClient(GlobalConstants.baseUrl),
  );
}

/// для локального хранения данных
void _dataSourceModule() async {
  final sharedPreferences = SharedPreferences.getInstance();

  locator.registerSingleton(GlobalTaskDataSource(sharedPreferences));
}

void _apiServiceModule() async {
  /// для авторизованной зоны
  locator.registerSingleton(TaskApiService(locator.getAsync()));
}

/// для репозиторий
void _repositoryModule() {
  locator.registerFactory(() => TaskRepository());
}

/// для useCase
void _useCaseModule() {
  locator.registerFactory(() => GetTaskListUseCase());
  locator.registerFactory(() => SetTaskListSourceUseCase());
  locator.registerFactory(() => GetTaskListSourceUseCase());
}
