import 'dart:convert';

class KpiData {
  final String id;
  final List<ValueData> value;
  final List<double> compilationData;
  final List<List<double>> dataList;

  KpiData({
    required this.id,
    required this.value,
    required this.compilationData,
    required this.dataList,
  });

  // Factory constructor for creating a new instance from a JSON map
  factory KpiData.fromJson(Map<String, dynamic> json) {
    return KpiData(
      id: json['id'] as String,
      value: (json['value'] as List<dynamic>)
          .map((item) => ValueData.fromJson(item as Map<String, dynamic>))
          .toList(),
      compilationData: List<double>.from(json['compilationData']),
      dataList: (json['dataList'] as List<dynamic>)
          .map((list) => List<double>.from(list as List<dynamic>))
          .toList(),
    );
  }

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value.map((item) => item.toJson()).toList(),
      'compilationData': compilationData,
      'dataList': dataList.map((list) => list.toList()).toList(),
    };
  }
}
class ValueData {
  final String date;
  final int data;

  ValueData({
    required this.date,
    required this.data,
  });

  // Factory constructor for creating a new instance from a JSON map
  factory ValueData.fromJson(Map<String, dynamic> json) {
    return ValueData(
      date: json['date'] as String,
      data: json['data'] as int,
    );
  }

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'data': data,
    };
  }
}
