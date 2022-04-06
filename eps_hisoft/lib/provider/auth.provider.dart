import 'dart:convert';
import 'dart:io';
import 'package:eps_hisoft/models/bank.dart';
import 'package:eps_hisoft/screens/home.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'package:eps_hisoft/models/user.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLogged = false;
  String _authToken = '';
  String _userId = '';
  User? user;
  final Map<String, List<Map<String, dynamic>>> _userFunc = {
    'Thông tin cá nhân': [
      {
        'Email': '',
        'phone': '',
        'Ngày sinh': '',
        'Vai trò': '',
        'Ngày bắt đầu làm việc': '',
        'Nơi ở hiện tại': '',
        'Quê quán': '',
      }
    ],
    'Thông tin ngân hàng': [
      {
        'Tên': '',
        'Chi nhánh': '',
        'Số tài khoản': '',
        'Ngân hàng': '',
      }
    ]
  };

  String get authToken {
    return _authToken;
  }

  Map<String, List<Map<String, dynamic>>> get getUserFunc {
    return _userFunc;
  }

  void set setUserFunc(User user) {
    _userFunc['Thông tin cá nhân'] = [
      {
        'Email': user.email,
        'phone': user.phone,
        'Ngày sinh': Helper.formatTimeZoneToString(user.dob),
        'Vai trò': user.role,
        'Ngày bắt đầu làm việc':
            Helper.formatTimeZoneToString(user.startWorkAt),
        'Nơi ở hiện tại': user.currentLocation,
        'Quê quán': user.hometown,
      }
    ];

    _userFunc['Thông tin ngân hàng'] = user.banksInfo!
        .map((bank) => {
              'Tên': bank.name,
              'Chi nhánh': bank.branch,
              'Số tài khoản': bank.accNo,
              'Ngân hàng': bank.accName,
            })
        .toList();
  }

  set setAuthToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  String? get getUserId {
    return _userId;
  }

  void set setUserId(String u) {
    _userId = u;
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
      var url = Uri.parse('${ApiBase.instance.baseUrl}/login');

      final response = await http.post(url, body: {
        'email': username,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          int status = jsonDecode['status'];
          if (status == 200) {
            _apiResponse.Data = User.fromMap(jsonDecode['data']);
            User user = User.fromMap(jsonDecode['data']);
            setUserId = user.id;
            setAuthToken = user.accessToken;
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('authToken', user.accessToken);
            prefs.setString('userId', user.id);
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

  Future<ApiResponse> getUserApi(String userId, String bearerToken) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      var url =
          Uri.parse('${ApiBase.instance.baseUrl}/employees/detail/' + userId);
      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http.get(url, headers: header);

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          int status = jsonDecode['status'];
          if (status == 200) {
            _apiResponse.Data = User.fromMap(jsonDecode['data']);
            User user = User.fromMap(jsonDecode['data']);
            this.user = user;
            setUserFunc = user;
            AppLog.d(user.toString(), tag: 'user');
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

  Future<ApiResponse> updateUser(
    String currentLocation,
    String dob,
    String homeTown,
    String email,
    String phone,
    String bearerToken,
  ) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      var url = Uri.parse('${ApiBase.instance.baseUrl}/employees/update');
      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http.post(
        url,
        body: {
          'currentLocation': currentLocation,
          'dob': dob,
          'hometown': homeTown,
          'personalEmail': email,
          'phone': phone,
        },
        headers: header,
      );

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          int status = jsonDecode['status'];
          if (status == 200) {
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

  Future<ApiResponse> changePassword(
    String email,
    String newPassword,
    String oldPassword,
    String bearerToken,
  ) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      var url = Uri.parse('${ApiBase.instance.baseUrl}/change-password');
      var header = {
        'authorization': 'Bearer $bearerToken',
      };
      final response = await http.post(
        url,
        body: {
          'email': email,
          'newPassword': newPassword,
          'oldPassword': oldPassword,
        },
        headers: header,
      );

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonDecode = json.decode(response.body);
          int status = jsonDecode['status'];
          if (status == 200) {
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
