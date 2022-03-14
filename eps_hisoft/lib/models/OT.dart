import 'dart:convert';

class OT {
  final String date;
  final int approved;
  final String employee;
  final String from;
  final String to;
  final String note;
  final String project;
  final String reason;
  final String ship;
  final String updatedAt;
  final String createdAt;
  final String id;
  OT({
    required this.date,
    required this.approved,
    required this.employee,
    required this.from,
    required this.to,
    required this.note,
    required this.project,
    required this.reason,
    required this.ship,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  OT copyWith({
    String? date,
    int? approved,
    String? employee,
    String? from,
    String? to,
    String? note,
    String? project,
    String? reason,
    String? ship,
    String? updatedAt,
    String? createdAt,
    String? id,
  }) {
    return OT(
      date: date ?? this.date,
      approved: approved ?? this.approved,
      employee: employee ?? this.employee,
      from: from ?? this.from,
      to: to ?? this.to,
      note: note ?? this.note,
      project: project ?? this.project,
      reason: reason ?? this.reason,
      ship: ship ?? this.ship,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'approved': approved,
      'employee': employee,
      'from': from,
      'to': to,
      'note': note,
      'project': project,
      'reason': reason,
      'ship': ship,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory OT.fromMap(Map<String, dynamic> map) {
    return OT(
      date: map['date'] ?? '',
      approved: map['approved']?.toInt() ?? 0,
      employee: map['employee'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      note: map['note'] ?? '',
      project: map['project'] ?? '',
      reason: map['reason'] ?? '',
      ship: map['ship'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      createdAt: map['createdAt'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OT.fromJson(String source) => OT.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OT(date: $date, approved: $approved, employee: $employee, from: $from, to: $to, note: $note, project: $project, reason: $reason, ship: $ship, updatedAt: $updatedAt, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OT &&
        other.date == date &&
        other.approved == approved &&
        other.employee == employee &&
        other.from == from &&
        other.to == to &&
        other.note == note &&
        other.project == project &&
        other.reason == reason &&
        other.ship == ship &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        approved.hashCode ^
        employee.hashCode ^
        from.hashCode ^
        to.hashCode ^
        note.hashCode ^
        project.hashCode ^
        reason.hashCode ^
        ship.hashCode ^
        updatedAt.hashCode ^
        createdAt.hashCode ^
        id.hashCode;
  }
}
