import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'kpiData_model.dart';

class KpiInfoListModel {
  List<KpiInfo>? kpiInfo;

  KpiInfoListModel({this.kpiInfo});

  factory KpiInfoListModel.fromJson(Map<String, dynamic> json) {
    // Safeguard for unexpected `data` format
    if (json['data'] is! List) {
      throw FormatException(
          'Unexpected data format: Expected a list but got ${json['data'].runtimeType}');
    }

    return KpiInfoListModel(
      kpiInfo: (json['data'] as List<dynamic>)
          .map((e) => KpiInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': kpiInfo?.map((e) => e.toJson()).toList(),
    };
  }
}

class KpiInfo {
  String? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? type;
  List<KpiTarget>? target; // Updated to handle quarterly target data
  String? auth;
  bool? notification;
  bool? positiveDirection; // Updated field name
  String? kpiUnit;
  String? source; // Existing field for source
  String? periodicity; // New field
  String? calculate; // New field for howToCalculate
  String? formula; // New field for calculationFormat
  List<RelatedKpi>? relatedKpis;
  KpiData? kpiData;

  KpiInfo({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.type,
    this.target,
    this.auth,
    this.notification,
    this.positiveDirection,
    this.kpiUnit,
    this.source,
    this.periodicity,
    this.calculate,
    this.formula,
    this.relatedKpis,
    this.kpiData,
  });

  factory KpiInfo.fromJson(Map<String, dynamic> json) {
    return KpiInfo(
      id: json['id'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      type: json['type'] as String?,
      target: (json['target'] as List<dynamic>?)
          ?.map((e) => KpiTarget.fromJson(e))
          .toList(), // Map the target list
      auth: json['auth'] as String?,
      notification: json['notification'] as bool?,
      positiveDirection: json['positiveDirection'] as bool?,
      kpiUnit: json['unit'] as String?,
      source: json['source'] as String?,
      periodicity: json['periodicity'] as String?,
      calculate: json['calculate'] as String?,
      formula: json['formula'] as String?,
      relatedKpis: (json['relatedKpis'] as List<dynamic>?)
          ?.map((e) => RelatedKpi.fromJson(e))
          .toList(),
      kpiData:
      json['kpiData'] != null ? KpiData.fromJson(json['kpiData']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'type': type,
      'target': target?.map((e) => e.toJson()).toList(), // Serialize the target list
      'auth': auth,
      'notification': notification,
      'positiveDirection': positiveDirection, // Serialize the field
      'unit': kpiUnit,
      'source': source,
      'periodicity': periodicity,
      'calculate': calculate,
      'formula': formula,
      'relatedKpis': relatedKpis?.map((e) => e.toJson()).toList(),
      'kpiData': kpiData?.toJson(),
    };
  }
  String getLocalizedName(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? (nameAr ?? '') : (nameEn ?? '');
  }

  String getLocalizedDescription(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar'
        ? (descriptionAr ?? '')
        : (descriptionEn ?? '');
  }
}

class RelatedKpi {
  String? id;
  String? nameAr;
  String? nameEn;

  RelatedKpi({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  String getLocalizedName(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    if (locale.languageCode == 'ar') {
      return nameAr ?? '';
    } else {
      return nameEn ?? '';
    }
  }

  factory RelatedKpi.fromJson(Map<String, dynamic> json) {
    return RelatedKpi(
      id: json['_id'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }
}

class KpiTarget {
  String? quarter; // String for quarter (e.g., "Q1", "Q2")
  String? target; // String for target (e.g., "10.00", "15.00")
  String? achievedSum; // String for achievedSum (e.g., "0.00", "7198110.00")
  double? percentageAchieved; // Integer for percentageAchieved (e.g., 0, 100)

  KpiTarget({
    this.quarter,
    this.target,
    this.achievedSum,
    this.percentageAchieved,
  });

  factory KpiTarget.fromJson(Map<String, dynamic> json) {
    return KpiTarget(
      quarter: json['quarter'] as String?, // Assign directly as String
      target: json['target'] as String?, // Assign as String
      achievedSum: json['achievedSum'] as String?, // Assign as String
        percentageAchieved: (json['percentageAchieved'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quarter': quarter,
      'target': target,
      'achievedSum': achievedSum,
      'percentageAchieved': percentageAchieved,
    };
  }
}