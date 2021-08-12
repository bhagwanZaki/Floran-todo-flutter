import 'dart:convert';

class ChartDataList {
  static List<ChartData> items = [];
}

class ChartData {
  final int data;
  final int date;

  ChartData(
    this.data,
    this.date,
  );

  ChartData copyWith({
    int? data,
    int? date,
  }) {
    return ChartData(
      data ?? this.data,
      date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'date': date,
    };
  }

  factory ChartData.fromMap(Map<String, dynamic> map) {
    return ChartData(
      map['data'],
      map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartData.fromJson(String source) =>
      ChartData.fromMap(json.decode(source));

  @override
  String toString() => 'ChartData(data: $data, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChartData && other.data == data && other.date == date;
  }

  @override
  int get hashCode => data.hashCode ^ date.hashCode;
}
