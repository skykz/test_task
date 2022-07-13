import 'dart:convert';

import 'package:flutter_core/core/abstarct/constant/core_common_contant.dart';

class TaskListModel {
  List<TaskModel> tasks;
  TaskListModel({
    this.tasks,
  });

  factory TaskListModel.fromJson(List<dynamic> listData) => TaskListModel(
        tasks: List<TaskModel>.from(listData.map((x) => TaskModel.fromJson(x))),
      );

  factory TaskListModel.fromRawJson(String str) =>
      TaskListModel.fromJson(json.decode(str));

  String toJson() => json.encode(tasks.toList());
}

class TaskModel {
  TaskModel({
    this.id,
    this.userId,
    this.title,
    this.dueOn,
    this.status,
    this.deadline,
    this.reminder,
    this.repeat,
    this.startTime,
  });

  int id;
  int userId;
  String title;
  String reminder;
  String repeat;
  String deadline;
  String startTime;
  DateTime dueOn;
  Status status;

  factory TaskModel.fromRawJson(String str) =>
      TaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],
      reminder: json["reminder"] ?? CoreConstant.empty,
      repeat: json["repeat"] ?? CoreConstant.empty,
      startTime: json["startTime"] ?? CoreConstant.empty,
      deadline: json["deadline"] ?? CoreConstant.empty,
      dueOn: DateTime.parse(json["due_on"]),
      status: statusValues.map[json["status"]]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "repeat": repeat,
        "deadline": deadline,
        "startTime": startTime,
        "reminder": reminder,
        "due_on": dueOn?.toIso8601String() ?? '2022-01-30',
        "status": statusValues.reverse[status],
      };
}

// ignore: constant_identifier_names
enum Status { ALL, COMPLETED, PENDING }

final statusValues = EnumValues({
  "all": Status.ALL,
  "completed": Status.COMPLETED,
  "pending": Status.PENDING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
