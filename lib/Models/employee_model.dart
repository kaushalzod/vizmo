import 'dart:convert';

import 'package:flutter/foundation.dart';

class Employee {
  String? createdAt;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  List<String>? department;
  String? birthday;
  String? country;
  String? id;
  Employee({
    this.createdAt,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.department,
    this.birthday,
    this.country,
    this.id,
  });

  Employee copyWith({
    String? createdAt,
    String? name,
    String? avatar,
    String? email,
    String? phone,
    List<String>? department,
    String? birthday,
    String? country,
    String? id,
  }) {
    return Employee(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      birthday: birthday ?? this.birthday,
      country: country ?? this.country,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (department != null) {
      result.addAll({'department': department});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (id != null) {
      result.addAll({'id': id});
    }

    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      createdAt: map['createdAt'],
      name: map['name'],
      avatar: map['avatar'],
      email: map['email'],
      phone: map['phone'],
      department: List<String>.from(map['department']),
      birthday: map['birthday'],
      country: map['country'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(createdAt: $createdAt, name: $name, avatar: $avatar, email: $email, phone: $phone, department: $department, birthday: $birthday, country: $country, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.avatar == avatar &&
        other.email == email &&
        other.phone == phone &&
        listEquals(other.department, department) &&
        other.birthday == birthday &&
        other.country == country &&
        other.id == id;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        department.hashCode ^
        birthday.hashCode ^
        country.hashCode ^
        id.hashCode;
  }
}
