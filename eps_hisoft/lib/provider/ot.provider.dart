import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:eps_hisoft/models/OT.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';

class OtProvider with ChangeNotifier {
  List<OT> ots = [];

  List<DateTime> getSpecialDates() {
    final List<DateTime> dates = <DateTime>[];
    final DateTime startDate =
        DateTime.now().subtract(const Duration(days: 200));
    final DateTime endDate = DateTime.now().add(const Duration(days: 500));
    final Random random = Random();
    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 25))) {
      for (int i = 0; i < 3; i++) {
        dates.add(date.add(Duration(days: random.nextInt(i + 4))));
      }
    }

    return dates;
  }

  Future<ApiResponse> getListOT(
      String from, String to, String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.instance.baseUrl}/ot/search');

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
          List<OT> _ots = List<OT>.from(
            jsonDecode['data'].map(
              (model) => OT.fromMap(model),
            ),
          );
          ots = _ots;
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

  Future<ApiResponse> createNewOT(String start, String end, String projectId,
      String note, String ship, String otDate, String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.instance.baseUrl}/ot');

      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http
          .post(uri,
              body: {
                'start': start,
                'end': end,
                'project': projectId,
                'ship': ship,
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
