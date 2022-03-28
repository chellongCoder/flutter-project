import 'dart:convert';

class Bank {
  final String accName;
  final String accNo;
  final String branch;
  final String createdAt;
  final String employee;
  final bool main;
  final String name;
  final String updatedAt;
  final String id;
  Bank({
    required this.accName,
    required this.accNo,
    required this.branch,
    required this.createdAt,
    required this.employee,
    required this.main,
    required this.name,
    required this.updatedAt,
    required this.id,
  });

  Bank copyWith({
    String? accName,
    String? accNo,
    String? branch,
    String? createdAt,
    String? employee,
    bool? main,
    String? name,
    String? updatedAt,
    String? id,
  }) {
    return Bank(
      accName: accName ?? this.accName,
      accNo: accNo ?? this.accNo,
      branch: branch ?? this.branch,
      createdAt: createdAt ?? this.createdAt,
      employee: employee ?? this.employee,
      main: main ?? this.main,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accName': accName,
      'accNo': accNo,
      'branch': branch,
      'createdAt': createdAt,
      'employee': employee,
      'main': main,
      'name': name,
      'updatedAt': updatedAt,
      'id': id,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      accName: map['accName'] ?? '',
      accNo: map['accNo'] ?? '',
      branch: map['branch'] ?? '',
      createdAt: map['createdAt'] ?? '',
      employee: map['employee'] ?? '',
      main: map['main'] ?? false,
      name: map['name'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Bank(accName: $accName, accNo: $accNo, branch: $branch, createdAt: $createdAt, employee: $employee, main: $main, name: $name, updatedAt: $updatedAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bank &&
        other.accName == accName &&
        other.accNo == accNo &&
        other.branch == branch &&
        other.createdAt == createdAt &&
        other.employee == employee &&
        other.main == main &&
        other.name == name &&
        other.updatedAt == updatedAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return accName.hashCode ^
        accNo.hashCode ^
        branch.hashCode ^
        createdAt.hashCode ^
        employee.hashCode ^
        main.hashCode ^
        name.hashCode ^
        updatedAt.hashCode ^
        id.hashCode;
  }
}
