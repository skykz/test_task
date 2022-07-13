import 'dart:core';
import 'package:dio/dio.dart';
import 'network_call_routes.dart';

class TaskApiService {
  final Future<Dio> _httpClient;
  TaskApiService(this._httpClient);

  /// get all tasks from rest api server
  Future<Response> getTaskListRequest() async {
    final response = await _httpClient;
    return response.get(NetworkCallRoutes.getAllTasksApi);
  }
}
