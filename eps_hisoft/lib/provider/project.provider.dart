import 'dart:convert';
import 'dart:io';

import 'package:eps_hisoft/models/project.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectProvider with ChangeNotifier {
  List<Project> projects = [];

  Future<ApiResponse> getListProjects(String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.instance.baseUrl}/projects');

      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http.get(uri, headers: header);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          List<Project> _projects = List<Project>.from(
            jsonDecode['data'].map(
              (model) => Project.fromMap(model),
            ),
          );
          projects = _projects;
          _apiResponse.Data = jsonDecode;
          notifyListeners();
          break;
        default:
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }
}
