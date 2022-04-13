import 'dart:convert';

class Checkin {
  String? checkin;
  String? location;
  String? purpose;
  String? id;
  String? employeeId;
  Checkin({
    this.checkin,
    this.location,
    this.purpose,
    this.id,
    this.employeeId,
  });

  Checkin copyWith({
    String? checkin,
    String? location,
    String? purpose,
    String? id,
    String? employeeId,
  }) {
    return Checkin(
      checkin: checkin ?? this.checkin,
      location: location ?? this.location,
      purpose: purpose ?? this.purpose,
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (checkin != null) {
      result.addAll({'checkin': checkin});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (purpose != null) {
      result.addAll({'purpose': purpose});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (employeeId != null) {
      result.addAll({'employeeId': employeeId});
    }

    return result;
  }

  factory Checkin.fromMap(Map<String, dynamic> map) {
    return Checkin(
      checkin: map['checkin'],
      location: map['location'],
      purpose: map['purpose'],
      id: map['id'],
      employeeId: map['employeeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Checkin.fromJson(String source) =>
      Checkin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Checkin(checkin: $checkin, location: $location, purpose: $purpose, id: $id, employeeId: $employeeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Checkin &&
        other.checkin == checkin &&
        other.location == location &&
        other.purpose == purpose &&
        other.id == id &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode {
    return checkin.hashCode ^
        location.hashCode ^
        purpose.hashCode ^
        id.hashCode ^
        employeeId.hashCode;
  }
}
