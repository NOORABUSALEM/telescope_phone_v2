import 'dart:convert';

class KpiData {
  final String id;
  final ValueData value; // Single ValueData object
  final List<double> compilationData;
  final List<DataList> dataList; // Updated to handle nested lists

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
      value: json['value'] != null
          ? ValueData.fromJson(json['value'] as Map<String, dynamic>)
          : ValueData.defaultValue(),
      compilationData: (json['compilationData'] as List<dynamic>?)
          ?.map((item) => (item as num).toDouble())
          .toList() ??
          [],
      dataList: (json['dataList'] as List<dynamic>?)
          ?.map((item) => DataList.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  // Method for converting an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value.toJson(),
      'compilationData': compilationData,
      'dataList': dataList.map((item) => item.toJson()).toList(),
    };
  }
}

class ValueData {
  final String date;
  final double data;

  ValueData({
    required this.date,
    required this.data,
  });

  factory ValueData.fromJson(Map<String, dynamic> json) {
    return ValueData(
      date: json['date'] as String,
      data: (json['data'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'data': data,
    };
  }

  factory ValueData.defaultValue() {
    return ValueData(date: "1970-01-01", data: 0.0);
  }
}

class DataList {
  final List<String> dates;
  final List<double> data;
  final List<String?> events; // Add events list

  DataList({
    required this.dates,
    required this.data,
    required this.events,
  });

  factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
      dates: (json['dates'] as List<dynamic>).map((item) => item as String).toList(),
      data: (json['data'] as List<dynamic>).map((item) => (item as num).toDouble()).toList(),
      events: (json['events'] as List<dynamic>).map((item) => item as String?).toList(), // Handle events
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates,
      'data': data,
      'events': events, // Include events in JSON
    };
  }
}