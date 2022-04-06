import 'dart:io';

import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/widget/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static final routeName = '/change-password';
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String oldPassword = '';
  String rePassword = '';
  String newPassword = '';
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  void _updateUser() async {
    final authModel = Provider.of<AuthProvider>(context, listen: false);
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      print(newPassword + rePassword);
      if (newPassword != rePassword) {
        Helper.showError(context, 'nhập lại mật khẩu không khớp');
        return;
      }
      ApiResponse _apiResponse = await authModel.changePassword(
        authModel.user?.email ?? '',
        newPassword,
        oldPassword,
        authModel.authToken,
      );
      if ((_apiResponse.ApiError as ApiError) == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green,
        ));
      } else {
        Helper.showError(context, (_apiResponse.ApiError as ApiError).error);
      }
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Đổi mật khẩu'),
          )
        : AppBar(
            title: Text('Đổi mật khẩu'),
            centerTitle: true,
          );
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Container(
        child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordField(
                  fieldKey: Key('old password'),
                  labelText: 'Mật khẩu cũ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập thông tin';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    print('new value' + newValue.toString());
                    oldPassword = newValue ?? oldPassword;
                  },
                ),
                PasswordField(
                  fieldKey: Key('new repassword'),
                  labelText: 'Mật khẩu mới',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập thông tin';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newPassword = newValue ?? newPassword,
                ),
                PasswordField(
                  fieldKey: Key('old repassword'),
                  labelText: 'Nhập lại mật khẩu',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập thông tin';
                    }
                    return null;
                  },
                  onSaved: (newValue) => rePassword = newValue ?? rePassword,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: _updateUser,
                    child: const Text('Save'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
