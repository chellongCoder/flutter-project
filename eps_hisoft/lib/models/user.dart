import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:eps_hisoft/models/bank.dart';

class User {
  final String id;
  final String accessToken;
  final String email;
  final bool isReset;
  final String role;
  final String name;
  final String personalEmail;
  final String dob;
  final String startWorkAt;
  final String position;
  final String currentLocation;
  final String hometown;
  final String phone;
  final String state;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final List<Bank>? banksInfo;
  User({
    required this.id,
    required this.accessToken,
    required this.email,
    required this.isReset,
    required this.role,
    required this.name,
    required this.personalEmail,
    required this.dob,
    required this.startWorkAt,
    required this.position,
    required this.currentLocation,
    required this.hometown,
    required this.phone,
    required this.state,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    this.banksInfo,
  });

  User copyWith({
    String? id,
    String? accessToken,
    String? email,
    bool? isReset,
    String? role,
    String? name,
    String? personalEmail,
    String? dob,
    String? startWorkAt,
    String? position,
    String? currentLocation,
    String? hometown,
    String? phone,
    String? state,
    String? slug,
    String? createdAt,
    String? updatedAt,
    List<Bank>? banksInfo,
  }) {
    return User(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      isReset: isReset ?? this.isReset,
      role: role ?? this.role,
      name: name ?? this.name,
      personalEmail: personalEmail ?? this.personalEmail,
      dob: dob ?? this.dob,
      startWorkAt: startWorkAt ?? this.startWorkAt,
      position: position ?? this.position,
      currentLocation: currentLocation ?? this.currentLocation,
      hometown: hometown ?? this.hometown,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      banksInfo: banksInfo ?? this.banksInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accessToken': accessToken,
      'email': email,
      'isReset': isReset,
      'role': role,
      'name': name,
      'personalEmail': personalEmail,
      'dob': dob,
      'startWorkAt': startWorkAt,
      'position': position,
      'currentLocation': currentLocation,
      'hometown': hometown,
      'phone': phone,
      'state': state,
      'slug': slug,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'banksInfo': [],
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      accessToken: map['access_token'] ?? '',
      email: map['email'] ?? '',
      isReset: map['isReset'] ?? false,
      role: map['role'] ?? '',
      name: map['name'] ?? '',
      personalEmail: map['personalEmail'] ?? '',
      dob: map['dob'] ?? '',
      startWorkAt: map['startWorkAt'] ?? '',
      position: map['position'] ?? '',
      currentLocation: map['currentLocation'] ?? '',
      hometown: map['hometown'] ?? '',
      phone: map['phone'] ?? '',
      state: map['state'] ?? '',
      slug: map['slug'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      banksInfo: map['banksInfo'] != null
          ? List<Bank>.from(map['banksInfo']?.map((x) => Bank.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, accessToken: $accessToken, email: $email, isReset: $isReset, role: $role, name: $name, personalEmail: $personalEmail, dob: $dob, startWorkAt: $startWorkAt, position: $position, currentLocation: $currentLocation, hometown: $hometown, phone: $phone, state: $state, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt, banksInfo: $banksInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is User &&
        other.id == id &&
        other.accessToken == accessToken &&
        other.email == email &&
        other.isReset == isReset &&
        other.role == role &&
        other.name == name &&
        other.personalEmail == personalEmail &&
        other.dob == dob &&
        other.startWorkAt == startWorkAt &&
        other.position == position &&
        other.currentLocation == currentLocation &&
        other.hometown == hometown &&
        other.phone == phone &&
        other.state == state &&
        other.slug == slug &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.banksInfo, banksInfo);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accessToken.hashCode ^
        email.hashCode ^
        isReset.hashCode ^
        role.hashCode ^
        name.hashCode ^
        personalEmail.hashCode ^
        dob.hashCode ^
        startWorkAt.hashCode ^
        position.hashCode ^
        currentLocation.hashCode ^
        hometown.hashCode ^
        phone.hashCode ^
        state.hashCode ^
        slug.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        banksInfo.hashCode;
  }
}
