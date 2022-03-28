import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/widget/select_date.dart';
import 'package:flutter/material.dart';
import 'package:eps_hisoft/utils/helper.dart';

class FormValidate extends StatefulWidget {
  final String email;
  final String phone;
  final DateTime dob;
  final String currentLocation;
  final String homeTown;

  const FormValidate(
      {Key? key,
      required this.email,
      required this.phone,
      required this.dob,
      required this.currentLocation,
      required this.homeTown})
      : super(key: key);

  @override
  State<FormValidate> createState() => _FormValidateState();
}

class _FormValidateState extends State<FormValidate> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final dateController = SelectDateController();
  String email = '';
  String phone = '';
  late DateTime dob;
  String currentLocation = '';
  String homeTown = '';

  @override
  Widget build(BuildContext context) {
    email = widget.email;
    phone = widget.phone;
    dob = widget.dob;
    currentLocation = widget.currentLocation;
    homeTown = widget.homeTown;

    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            onSaved: (newValue) => email = newValue ?? email,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
                color: Theme.of(context).colorScheme.surface,
              ),
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.surface),
              hintText: 'Email',
            ),
            initialValue: email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else {
                if (!value!.isValidEmail()) {
                  return 'Check your email';
                }
              }
              return null;
            },
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            initialValue: phone,
            onSaved: (newValue) => phone = newValue ?? phone,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Text('+84'),
                  ],
                ),
              ),
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.surface),
              hintText: 'Số điện thoại',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SelectDate(
              width: 150,
              date: dob,
              controller: dateController,
              label: 'Ngày sinh',
            ),
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            initialValue: currentLocation,
            onSaved: (newValue) =>
                currentLocation = newValue ?? currentLocation,
            decoration: InputDecoration(
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    Icons.location_pin,
                    color: Theme.of(context).colorScheme.surface,
                  )),
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.surface),
              hintText: 'Nơi ở hiện tại',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            initialValue: homeTown,
            onSaved: (newValue) => homeTown = newValue ?? homeTown,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.add_location_alt,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.surface),
              hintText: 'Quê quán',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  _formKey.currentState!.save();
                  final dob = dateController.date;
                  AppLog.d(email +
                      phone +
                      dob.toString() +
                      currentLocation +
                      homeTown);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                } else {
                  print('invalid');
                  setState(() => _autoValidate = AutovalidateMode.always);
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
