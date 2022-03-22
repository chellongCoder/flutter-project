import 'dart:convert';

class Onsite {
  final String date;
  final String employee;
  final String from;
  final String to;
  final String note;
  final String project;
  final String reason;
  final String createdAt;
  final String updatedAt;
  final int approved;
  final String id;
  final String createBy;
  Onsite({
    required this.date,
    required this.employee,
    required this.from,
    required this.to,
    required this.note,
    required this.project,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.approved,
    required this.id,
    required this.createBy,
  });

  Onsite copyWith({
    String? date,
    String? employee,
    String? from,
    String? to,
    String? note,
    String? project,
    String? reason,
    String? createdAt,
    String? updatedAt,
    int? approved,
    String? id,
    String? createBy,
  }) {
    return Onsite(
      date: date ?? this.date,
      employee: employee ?? this.employee,
      from: from ?? this.from,
      to: to ?? this.to,
      note: note ?? this.note,
      project: project ?? this.project,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      approved: approved ?? this.approved,
      id: id ?? this.id,
      createBy: createBy ?? this.createBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'employee': employee,
      'from': from,
      'to': to,
      'note': note,
      'project': project,
      'reason': reason,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'approved': approved,
      'id': id,
      'createBy': createBy,
    };
  }

  factory Onsite.fromMap(Map<String, dynamic> map) {
    return Onsite(
      date: map['date'] ?? '',
      employee: map['employee'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      note: map['note'] ?? '',
      project: map['project'] ?? '',
      reason: map['reason'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      approved: map['approved']?.toInt() ?? 0,
      id: map['id'] ?? '',
      createBy: map['createBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Onsite.fromJson(String source) => Onsite.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Onsite(date: $date, employee: $employee, from: $from, to: $to, note: $note, project: $project, reason: $reason, createdAt: $createdAt, updatedAt: $updatedAt, approved: $approved, id: $id, createBy: $createBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Onsite &&
        other.date == date &&
        other.employee == employee &&
        other.from == from &&
        other.to == to &&
        other.note == note &&
        other.project == project &&
        other.reason == reason &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.approved == approved &&
        other.id == id &&
        other.createBy == createBy;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        employee.hashCode ^
        from.hashCode ^
        to.hashCode ^
        note.hashCode ^
        project.hashCode ^
        reason.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        approved.hashCode ^
        id.hashCode ^
        createBy.hashCode;
  }
}
