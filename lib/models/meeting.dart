import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  String? id;
  String subject;
  Timestamp timeStamp;
  Meeting({
    this.id,
    required this.subject,
    required this.timeStamp,
  });

  Meeting copyWith({
    String? id,
    String? subject,
    Timestamp? timeStamp,
  }) {
    return Meeting(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'timeStamp': timeStamp,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'],
      subject: map['subject'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source));

  @override
  String toString() =>
      'Meeting(id: $id, subject: $subject, timeStamp: $timeStamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meeting &&
        other.id == id &&
        other.subject == subject &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode => id.hashCode ^ subject.hashCode ^ timeStamp.hashCode;
}
