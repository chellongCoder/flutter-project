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

  void saveAndRedirectToHome(bool value) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool("isLogged", isLogged);
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   HomeScreen.routeName,
    //   ModalRoute.withName(HomeScreen.routeName),
    // );
    print('$value');
    setIsLogged = value;
    _storage.setItem("isLogged", 1);
  }

  Future<ApiResponse> authenticateUser(String username, String password) async {
    ApiResponse _apiResponse = new ApiResponse();

    try {
      var url = Uri.parse('${_baseUrl}/login');

      final response = await http.post(url, body: {
        'username': username,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          _apiResponse.Data = User.fromJson(json.decode(response.body));
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
