import 'dart:convert';

class TodosModel{
  static List<Todo> items = [];
}

class Todo {
  final int id;
  final String title;
  // ignore: non_constant_identifier_names
  final String date_created;
  final bool completed;
  // ignore: non_constant_identifier_names
  final String date_completed_by;
  // ignore: non_constant_identifier_names
  final String? completed_at;
  Todo({
    required this.id,
    required this.title,
    required this.date_created,
    required this.completed,
    required this.date_completed_by,
    required this.completed_at,
  });



  Todo copyWith({
    int? id,
    String? title,
    String? date_created,
    bool? completed,
    String? date_completed_by,
    String? completed_at,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      date_created: date_created ?? this.date_created,
      completed: completed ?? this.completed,
      date_completed_by: date_completed_by ?? this.date_completed_by,
      completed_at: completed_at ?? this.completed_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date_created': date_created,
      'completed': completed,
      'date_completed_by': date_completed_by,
      'completed_at': completed_at,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      date_created: map['date_created'],
      completed: map['completed'],
      date_completed_by: map['date_completed_by'],
      completed_at: map['completed_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, date_created: $date_created, completed: $completed, date_completed_by: $date_completed_by, completed_at: $completed_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.id == id &&
      other.title == title &&
      other.date_created == date_created &&
      other.completed == completed &&
      other.date_completed_by == date_completed_by &&
      other.completed_at == completed_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      date_created.hashCode ^
      completed.hashCode ^
      date_completed_by.hashCode ^
      completed_at.hashCode;
  }
}
