import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/constants/global_app_consts.dart';

class GlobalTaskDataSource {
  final Future<SharedPreferences> sharedPreferences;

  GlobalTaskDataSource(this.sharedPreferences);

  /// getting task list
  Future<String> get taskList async {
    final prefs = await sharedPreferences;
    return prefs.getString(GlobalConstants.taskList);
  }

  /// setting new task
  Future<void> setTask(String taskListString) async {
    final prefs = await sharedPreferences;
    prefs.setString(GlobalConstants.taskList, taskListString);
  }
}
