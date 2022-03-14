import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:eps_hisoft/models/OT.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';

class OtProvider with ChangeNotifier {
  List<OT> ots = [];

  Future<ApiResponse> getListOT(
      String from, String to, String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final uri = Uri.parse('${ApiBase.baseUrl}/login');

      var header = {
        'authorization': bearerToken,
        'Content-Type': 'application/json;charset=UTF-8'
      };
      final response = await http.post(uri,
          body: {
            'from': from,
            'to': to,
          },
          headers: header);
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }
}
