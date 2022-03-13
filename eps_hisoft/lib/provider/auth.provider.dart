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
  final LocalStorage _storage = new LocalStorage('todo_app');
  String _authToken = '';

  String get authToken {
    return _authToken;
  }

  set setAuthToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  LocalStorage get storage {
    return _storage;
  }

  bool get isLogged {
    return _isLogged;
  }

  void set setIsLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  void saveAndRedirectToHome(bool value) async {
    print('$value');
    setIsLogged = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', value);
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<ApiResponse> authenticateUser(String username, String password) async {
    ApiResponse _apiResponse = new ApiResponse();

    try {
      var url = Uri.parse('${_baseUrl}/login');

      final response = await http.post(url, body: {
        'email': username,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          _apiResponse.Data = User.fromMap(jsonDecode);
          User user = User.fromMap(jsonDecode);
          setAuthToken = user.accessToken;
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', user.accessToken);
          notifyListeners();
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
