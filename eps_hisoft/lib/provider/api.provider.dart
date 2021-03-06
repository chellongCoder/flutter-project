import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiBase {
  static ApiBase? _instance;
  String baseUrl = "";

  ApiBase._() {
    String apiUrl = dotenv.get('CLIENT_URL');
    print(apiUrl);
    baseUrl = apiUrl;
  }

  static ApiBase get instance => _instance ??= ApiBase._();
}

class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  late Object _data;
  // _apiError will hold the error object
  Object? _apiError;

  Object get Data => _data;
  set Data(Object data) => _data = data;

  Object get ApiError => _apiError as Object;
  set ApiError(Object error) => _apiError = error;
}

class ApiError {
  String error;
  ApiError({
    required this.error,
  });

  ApiError copyWith({
    String? error,
  }) {
    return ApiError(
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));

  @override
  String toString() => 'ApiError(error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiError && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
