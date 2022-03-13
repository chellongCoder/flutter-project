import 'dart:convert';

class User {
  final String id;
  final String accessToken;
  final String email;
  final bool isReset;
  final String role;
  final String name;

  User({
    required this.id,
    required this.accessToken,
    required this.email,
    required this.isReset,
    required this.role,
    required this.name,
  });

  User copyWith({
    String? id,
    String? accessToken,
    String? email,
    bool? isReset,
    String? role,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      isReset: isReset ?? this.isReset,
      role: role ?? this.role,
      name: name ?? this.name,
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
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['data']['_id'] ?? '',
      accessToken: map['data']['access_token'] ?? '',
      email: map['data']['email'] ?? '',
      isReset: map['data']['isReset'] ?? false,
      role: map['data']['role'] ?? '',
      name: map['data']['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, accessToken: $accessToken, email: $email, isReset: $isReset, role: $role, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.accessToken == accessToken &&
        other.email == email &&
        other.isReset == isReset &&
        other.role == role &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accessToken.hashCode ^
        email.hashCode ^
        isReset.hashCode ^
        role.hashCode ^
        name.hashCode;
  }
}
