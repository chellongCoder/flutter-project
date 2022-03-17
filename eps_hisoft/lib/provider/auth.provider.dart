import 'dart:convert';
import 'dart:io';
import 'package:eps_hisoft/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:eps_hisoft/models/user.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLogged = false;
  String _baseUrl = "https://api-eps.hisoft.com.vn/api";
  String _authToken = '';

  String get authToken {
    return _authToken;
  }

  set setAuthToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  bool get isLogged {
    return _isLogged;
  }

  void set setIsLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  void saveAndRedirectToHome() async {}

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setAuthToken = '';
  }

  Future<ApiResponse> authenticateUser(String username, String password) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      var url = Uri.parse('${_baseUrl}/login');

      final response = await http.post(url, body: {
        'email': username,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          int status = jsonDecode['status'];
          if (status == 200) {
            _apiResponse.Data = User.fromMap(jsonDecode);
            User user = User.fromMap(jsonDecode);
            setAuthToken = user.accessToken;
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('authToken', user.accessToken);
            notifyListeners();
          } else {
            _apiResponse.ApiError = ApiError(error: jsonDecode['message']);
          }
          break;
        case 401:
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }
}
