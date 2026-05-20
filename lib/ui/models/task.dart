import 'dart:convert';

import 'package:floor/floor.dart';

enum TaskStatus { pending, completed }

@Entity(tableName: 'Task')
class Task {
  @primaryKey
  final int id;
  @ColumnInfo(name: 'title')
  final String title;
  @ColumnInfo(name: 'date')
  final String date;
  @ColumnInfo(name: 'description')
  final String description;
  @ColumnInfo(name: 'startTime')
  final String startTime;
  @ColumnInfo(name: 'endTime')
  final String endTime;
  @ColumnInfo(name: 'status')
  final TaskStatus status;
  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  Task copyWith({
    int? id,
    String? title,
    String? date,
    String? description,
    String? startTime,
    String? endTime,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      status: map['status'] != null
          ? TaskStatus.values[map['status']]
          : TaskStatus.pending,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, title: $title, date: $date, description: $description, startTime: $startTime, endTime: $endTime, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.date == date &&
        other.description == description &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        date.hashCode ^
        description.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        status.hashCode;
  }
}
