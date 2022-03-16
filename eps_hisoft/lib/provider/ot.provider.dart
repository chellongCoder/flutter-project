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
      final uri = Uri.parse('${ApiBase.baseUrl}/ot/search');

      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http.post(uri,
          body: {
            'from': from,
            'to': to,
          },
          headers: header);
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
}
