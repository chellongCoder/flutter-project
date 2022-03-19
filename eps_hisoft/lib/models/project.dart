import 'dart:convert';

import 'package:flutter/foundation.dart';

class Project {
  final String id;
  final String name;
  final List<String> members;
  final String start;
  final String state;
  final String end;
  final String createAt;
  final String updateAt;

  Project({
    required this.id,
    required this.name,
    required this.members,
    required this.start,
    required this.state,
    required this.end,
    required this.createAt,
    required this.updateAt,
  });

  Project copyWith({
    String? id,
    String? name,
    List<String>? members,
    String? start,
    String? state,
    String? end,
    String? createAt,
    String? updateAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      start: start ?? this.start,
      state: state ?? this.state,
      end: end ?? this.end,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'members': members,
      'start': start,
      'state': state,
      'end': end,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      members: List<String>.from(map['members']),
      start: map['start'] ?? '',
      state: map['state'] ?? '',
      end: map['end'] ?? '',
      createAt: map['createAt'] ?? '',
      updateAt: map['updateAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(id: $id, name: $name, members: $members, start: $start, state: $state, end: $end, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.id == id &&
        other.name == name &&
        listEquals(other.members, members) &&
        other.start == start &&
        other.state == state &&
        other.end == end &&
        other.createAt == createAt &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        members.hashCode ^
        start.hashCode ^
        state.hashCode ^
        end.hashCode ^
        createAt.hashCode ^
        updateAt.hashCode;
  }
}
