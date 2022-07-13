// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_core/core/abstarct/constant/core_common_contant.dart';
import 'package:flutter_core/core/data/abstract/exeption/exeption.dart';

/// модель для ошибки при авторизации
class AuthException extends HttpRequestException {
  int status;
  String detail;

  AuthException({
    this.status,
    this.detail,
  }) : super(detail, status, HttpTypeError.http);

  factory AuthException.fromJson(
          Map<String, dynamic> map, String defaultError, int code) =>
      AuthException(
        status: map['status'],
        detail: map['detail'] ?? defaultError ?? CoreConstant.empty,
      );
}
