import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eps_hisoft/models/onsite.dart';
import 'package:http/http.dart' as http;

import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';

class OnsiteProvider with ChangeNotifier {
  List<Onsite> onsites = [];

  Future<ApiResponse> getListOnsite(
      String from, String to, String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.baseUrl}/onsite/search');

      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http
          .post(uri,
              body: {
                'from': from,
                'to': to,
              },
              headers: header)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          List<Onsite> _ots = List<Onsite>.from(
            jsonDecode['data'].map(
              (model) => Onsite.fromMap(model),
            ),
          );
          onsites = _ots;
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

  Future<ApiResponse> createNewOnsite(
    String start,
    String end,
    String projectId,
    String note,
    String otDate,
    String bearerToken,
  ) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.baseUrl}/onsite');

      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http
          .post(uri,
              body: {
                'start': start,
                'end': end,
                'project': projectId,
                'ot_date': otDate,
                'note': note,
              },
              headers: header)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _apiResponse.ApiError = ApiError(error: "Server timeout.");

          // Time has run out, do what you wanted to do.
          throw TimeoutException(
              'The connection has timed out, Please try again!'); // Request Timeout response status code
        },
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          bool check = jsonDecode['status'];
          if (check) {
            _apiResponse.Data = jsonDecode;
          } else {
            _apiResponse.ApiError =
                ApiError.fromJson(json.decode(response.body));
          }
          notifyListeners();
          break;
        default:
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    } catch (error) {
      throw error.toString();
    }
    return _apiResponse;
  }
}
