// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_core/core/presentation/abstract/bloc/core_state.dart';
import 'package:test_task/feature/data/task/data/task_data_model.dart';

///наш стейт когда узер выбрал предмет и приступил к поиску вопросов
class TaskState extends CoreState {
  final bool isLoading;
  final TaskListModel taskModel;
  final List<Status> status;

  TaskState({this.isLoading = false, this.taskModel, this.status = const []})
      : super();

  TaskState copyWith({
    bool isLoading = false,
    TaskListModel taskModel,
    List<Status> status,
  }) =>
      TaskState(isLoading: isLoading, taskModel: taskModel, status: status);
  @override
  List<Object> get props => [isLoading, taskModel, status];
}

///наш стейт когда узер выбрал предмет и приступил к поиску вопросов
class UstudyGiveawayErrorState extends CoreState {
  final String errorTxt;

  UstudyGiveawayErrorState({this.errorTxt}) : super();

  UstudyGiveawayErrorState copyWith({
    String errorTxt,
  }) =>
      UstudyGiveawayErrorState(errorTxt: errorTxt);

  @override
  List<Object> get props => [errorTxt];
}

///наш стейт когда узер выбрал предмет и приступил к поиску вопросов
class CreateTaskState extends CoreState {
  final bool isLoading;
  final bool isSaved;
  CreateTaskState({this.isLoading = false, this.isSaved = false}) : super();

  CreateTaskState copyWith({
    bool isLoading = false,
    bool isSaved = false,
  }) =>
      CreateTaskState(isLoading: isLoading, isSaved: isSaved);
  @override
  List<Object> get props => [isLoading, isSaved];
}

///наш стейт когда узер выбрал предмет и приступил к поиску вопросов
class SearchTaskState extends CoreState {
  final bool isLoading;
  final TaskListModel taskModel;
  SearchTaskState({
    this.isLoading = false,
    this.taskModel,
  }) : super();

  SearchTaskState copyWith({
    bool isLoading = false,
    bool isSaved = false,
    TaskListModel taskModel,
  }) =>
      SearchTaskState(isLoading: isLoading, taskModel: taskModel);
  @override
  List<Object> get props => [isLoading, taskModel];
}
